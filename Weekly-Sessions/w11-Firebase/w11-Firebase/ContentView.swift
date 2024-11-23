import SwiftUI
import FirebaseCore
import FirebaseFirestore

// MARK: - View Models
class StudentViewModel: ObservableObject {
    private let db = Firestore.firestore()
    @Published var students: [Student] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var showError = false
    
    func checkIfNameExists(_ name: String) async throws -> Bool {
        let snapshot = try await db.collection("students")
            .whereField("name", isEqualTo: name)
            .getDocuments()
        return !snapshot.documents.isEmpty
    }
    
    func addStudent(_ student: Student) async {
        isLoading = true
        
        do {
            // Check if name exists
            let nameExists = try await checkIfNameExists(student.name)
            if nameExists {
                errorMessage = "A student with the name '\(student.name)' already exists."
                showError = true
                isLoading = false
                return
            }
            
            // If name doesn't exist, add the student
            try db.collection("students").addDocument(from: student)
            await fetchAllStudents() // Refresh the list
            
        } catch {
            errorMessage = "Failed to add student: \(error.localizedDescription)"
            showError = true
        }
        
        isLoading = false
    }
    
    @MainActor
    func fetchAllStudents() async {
        isLoading = true
        students.removeAll()
        
        do {
            let snapshot = try await db.collection("students").getDocuments()
            students = try snapshot.documents.compactMap {
                try $0.data(as: Student.self)
            }
        } catch {
            errorMessage = "Failed to fetch students: \(error.localizedDescription)"
            showError = true
        }
        
        isLoading = false
    }
    
    func deleteStudent(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let studentId = students[index].id!
        
        isLoading = true
        db.collection("students").document(studentId).delete { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = "Failed to delete student: \(error.localizedDescription)"
                self.showError = true
            } else {
                self.students.remove(atOffsets: indexSet)
            }
            self.isLoading = false
        }
    }
}

// MARK: - Views
struct ContentView: View {
    @StateObject private var viewModel = StudentViewModel()
    @State private var showAddStudent = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    StudentListView(viewModel: viewModel)
                }
                .navigationTitle("Student Database")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showAddStudent = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.4))
                }
            }
        }
        .sheet(isPresented: $showAddStudent) {
            AddStudentView(viewModel: viewModel)
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred")
        }
        .task {
            await viewModel.fetchAllStudents()
        }
    }
}

struct StudentListView: View {
    @ObservedObject var viewModel: StudentViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.students) { student in
                StudentRow(student: student)
            }
            .onDelete(perform: viewModel.deleteStudent)
        }
        .listStyle(InsetGroupedListStyle())
        .refreshable {
            await viewModel.fetchAllStudents()
        }
        .overlay(Group {
            if viewModel.students.isEmpty && !viewModel.isLoading {
                ContentUnavailableView(
                    "No Students",
                    systemImage: "person.2.slash",
                    description: Text("Add your first student using the + button")
                )
            }
        })
    }
}

struct StudentRow: View {
    let student: Student
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(student.name)
                .font(.headline)
            
            HStack {
                Label("GPA: \(String(format: "%.2f", student.gpa))", systemImage: "chart.bar.fill")
                    .foregroundColor(.blue)
                Spacer()
                if student.isDiplomaLevel {
                    Label("Post Grad", systemImage: "graduationcap.fill")
                        .foregroundColor(.green)
                }
            }
            .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
}

struct AddStudentView: View {
    @ObservedObject var viewModel: StudentViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var gpa = ""
    @State private var isDiplomaLevel = false
    @State private var showValidationError = false
    @State private var validationErrorMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Student Information")) {
                    TextField("Student Name", text: $name)
                        .textContentType(.name)
                        .autocapitalization(.words)
                    
                    TextField("GPA", text: $gpa)
                        .keyboardType(.decimalPad)
                    
                    Toggle("Post Graduate Student", isOn: $isDiplomaLevel)
                }
                
                Section {
                    Button("Save Student") {
                        Task {
                            await saveStudent()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("Add Student")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Invalid Input", isPresented: $showValidationError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(validationErrorMessage)
            }
            .disabled(viewModel.isLoading)
        }
    }
    
    private func validateInput() -> Bool {
        // Validate name
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedName.isEmpty {
            validationErrorMessage = "Please enter a student name."
            return false
        }
        
        // Validate GPA
        guard let gpaValue = Double(gpa),
              gpaValue >= 0 && gpaValue <= 4 else {
            validationErrorMessage = "Please enter a valid GPA between 0 and 4."
            return false
        }
        
        return true
    }
    
    private func saveStudent() async {
        guard validateInput() else {
            showValidationError = true
            return
        }
        
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let student = Student(
            name: trimmedName,
            gpa: Double(gpa)!,
            isDiplomaLevel: isDiplomaLevel
        )
        
        await viewModel.addStudent(student)
        
        // Only dismiss if there's no error showing
        if !viewModel.showError {
            dismiss()
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

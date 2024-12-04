//
//  ContentView.swift
//  WrapUpPractice
//
//  Created by Preet Patel on 03/12/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore



struct AllSongsView: View {
    let db = Firestore.firestore()
    @State var songs:[Song] = []
    
    func insertMany(){
        
        
        do{
            let s1:Song = Song(name:"APT", artist:"Rose featuring Bruno Mars", genre:"pop", image:"https://charts-static.billboard.com/img/2024/10/rose-000-apt-kne-180x180.jpg", isFav:false)
            let s2:Song = Song(name:"All I Want For Christmas Is You", artist:"Mariah Carey", genre:"holiday", image:"https://charts-static.billboard.com/img/1994/12/mariah-carey-x65-alliwantforchristmasisyou-7ve-180x180.jpg", isFav:false)
            let s3:Song = Song(name:"St Chroma", artist:"Tyler the Creator", genre:"rap", image:"https://charts-static.billboard.com/img/2011/05/tyler-the-creator-loo-180x180.jpg", isFav:false)
            let s4:Song = Song(name:"Pink Pony Club", artist:"Chappell Roan", genre:"pop", image:"https://charts-static.billboard.com/img/2024/06/chappellroan-bhw-pinkponyclub-14t-180x180.jpg", isFav:false)
            let s5:Song = Song(name:"Squabble Up", artist:"Kendrick Lamar", genre:"rap", image:"https://charts-static.billboard.com/img/2010/10/kendrick-lamar-1hw-180x180.jpg", isFav:false)
            let s6 : Song = Song(name:"Blinding Lights", artist:"The Weeknd", genre:"pop", image:"https://placehold.co/180x180", isFav: false)
            
            // insert songs
            
            try db.collection("songs").addDocument(from: s1)
            try db.collection("songs").addDocument(from: s2)
            try db.collection("songs").addDocument(from: s3)
            try db.collection("songs").addDocument(from: s4)
            try db.collection("songs").addDocument(from: s5)
            try db.collection("songs").addDocument(from: s6)
        } catch {
            print(error)
        }
        
    }
    func getAllSongs(){
        songs.removeAll()
        db.collection("songs").getDocuments(){
            (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    do{
                        let songFromDb : Song = try document.data(as:Song.self)
                        songs.append(songFromDb)
                    }catch let err as NSError{
                        print(err)
                    }
                    
                }
            }
        }
    }
    func deleteSong(id: String?){
        guard let id else { return }
        
        db.collection("songs").document(id).delete(){
            (error) in
            if error == nil{
                print("Deleted successfully!")
                getAllSongs()
            }
            else{
                print("Got an Error!")
            }
        }
    }
    
    // TODO:
    // 1. Data transfer to second screen aand view
    // 2. Update info
    // 3. search (Optional)
    var body: some View {
        NavigationStack{
            VStack() {
                VStack{
                    HStack{
                        Button("Load Data"){
                            insertMany()
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .background(.green)
                        .cornerRadius(4)
                        
                        Button("Fetch Data"){
                            getAllSongs()
                            print(songs)
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .background(.green)
                        .cornerRadius(4)
                    }
                }.padding()
                
                
                List{
                    ForEach(songs, id: \.id){ song in
                        
                        NavigationLink{
                            SongDetailsView(song: song)
                        } label: {
                            HStack{
                                VStack(alignment: .leading){
                                    Text("\(song.name)")
                                        .font(.system(size: 18,weight:.medium))
                                        .multilineTextAlignment(.leading)
                                    Text("\(song.artist.uppercased())")
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                    
                                Button("Delete") {
                                    deleteSong(id: song.id)
                                }
                                .foregroundStyle(.red)
                                .buttonStyle(.borderless)
                          
                            }
                           
                        }.navigationTitle("Wrapped")
                        
                        
                        
                    }.onDelete(perform: {
                        indexSet in
                        
                        let removedSong = indexSet.map { songs[$0] }
                        deleteSong(id: removedSong[0].id)
                        
                    })
                }
                
                .onAppear(){
                    getAllSongs()
                }
            }
            
        }
        
    }
}

#Preview {
    AllSongsView()
}

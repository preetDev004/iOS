//
//  ContentView.swift
//  TRANSPORT-PREET
//
//  Created by Preet Patel on 13/11/24.
//

import SwiftUI
import CoreLocation
import MapKit

struct Transpotation : Identifiable{
    let id : UUID = UUID()
    var name : String
    var lat: Double
    var long: Double
    var category: MKPointOfInterestCategory
    var icon: String {
        switch self.category {
        case .gasStation:
            return "fuelpump"
        case .evCharger:
            return "powerplug"
        case .publicTransport:
            return "bus.fill"
        default:
            return ""
        }
    }
    
    init(name: String, lat: Double, long: Double, category: MKPointOfInterestCategory) {
        self.name = name
        self.lat = lat
        self.long = long
        self.category = category
    }
}



struct ContentView: View {
    @State var locationFromUI : String = ""
    @State var region : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 55), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var searchResults : [Transpotation] = []
    
    func findPointsOfIntrest(location: String){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            if (error != nil) {
                print("Error: \(error!.localizedDescription)")
                return
            }
            let coordinates : CLLocationCoordinate2D = placemarks![0].location!.coordinate

//           region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            
            let request = MKLocalPointsOfInterestRequest(center: coordinates, radius: 1000)
            request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.evCharger, .gasStation, .publicTransport])
            let search = MKLocalSearch(request: request)
            
            search.start(){
                (response, error) in
                
                if (error != nil){
                    print("No matching results!")
                    return
                }
                for item in response!.mapItems{
                    let tsItem = Transpotation(
                        name: item.name!,
                        lat: item.placemark.coordinate.latitude,
                        long: item.placemark.coordinate.longitude,
                        category: item.pointOfInterestCategory!)
                    searchResults.append(tsItem)
                    
                }
            }
            
        }

    }
    
    var body: some View {
        VStack {
          Text("Transportaion Finder")
                .font(.title2)
            
            HStack{
                TextField("Enter a Location..." , text:$locationFromUI)
                    .padding(12)
                    .border(Color.gray, width:2)
                    .cornerRadius(4)
                Button("Search"){
                    if(!locationFromUI.isEmpty){
                        findPointsOfIntrest(location: locationFromUI)
                    }
                }
                .padding(12)
                .background(.blue)
                .foregroundStyle(.white)
                .cornerRadius(4)
            }
            Map(coordinateRegion: $region)
                .frame(width: 370, height: 300)
                .cornerRadius(4)
            Spacer()
            if(!searchResults.isEmpty){
                List{
                    
                    ForEach(searchResults, id:\.self.id){
                        item in
                        
                        HStack{
                            Image(systemName: item.icon)
                                .frame(width: 25, height: 25)
                                .font(.system(size: 25))
                           
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .multilineTextAlignment(.leading)
                                Text("\(item.lat), \(item.long)")
                                    .font(.system(size: 10))
                            }
                            Spacer()
                            Button("Map"){
                                
                            }
                        }
                    }
                    
                    
                }
                .cornerRadius(4)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

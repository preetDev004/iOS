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
    var address : String
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
    
    init(name: String, address: String, lat: Double, long: Double, category: MKPointOfInterestCategory) {
        self.name = name
        self.address = address
        self.lat = lat
        self.long = long
        self.category = category
      
    }
}



struct ContentView: View {
    @State var locationFromUI : String = ""
    @State var region : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 55), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var searchResults : [Transpotation] = []
    @State var selectedLocation: Transpotation? = nil
    
    func findPointsOfIntrest(location: String){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            if (error != nil) {
                print("Error: \(error!.localizedDescription)")
                return
            }
            let coordinates : CLLocationCoordinate2D = placemarks![0].location!.coordinate
            
            let request = MKLocalPointsOfInterestRequest(center: coordinates, radius: 1000)
            request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.evCharger, .gasStation, .publicTransport])
            let search = MKLocalSearch(request: request)
            
            search.start(){
                (response, error) in
                
                if (error != nil){
                    print("No matching results!")
                    return
                }
                searchResults.removeAll()
                for item in response!.mapItems{

                    let tsItem = Transpotation(
                        name: item.name!,
                        address: (item.placemark.subThoroughfare != nil && item.placemark.thoroughfare != nil)
                                    ?"\(item.placemark.subThoroughfare!) \(item.placemark.thoroughfare!)"
                                    : "",
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
                        locationFromUI = ""
                    }
                }
                .padding(12)
                .background(.blue)
                .foregroundStyle(.white)
                .cornerRadius(4)
            }
            Map(coordinateRegion: $region, annotationItems: (selectedLocation != nil ? [selectedLocation!] : [])){ location in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long))
            }
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
                                if(!item.address.isEmpty){
                                    Text(item.address)
                                }
                                Text("\(item.lat), \(item.long)")
                                    .font(.system(size: 10))
                            }
                            Spacer()
                            Button("Map"){
                                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                                selectedLocation = item
                            }.buttonStyle(.borderless)
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

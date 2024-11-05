//
//  ContentView.swift
//  LocationsAndMaps
//
//  Created by Preet Patel on 05/11/24.
//

import SwiftUI
import CoreLocation
import MapKit


struct ContentView: View {
    @State var addr : String = ""
    @State var resultLabel : String = ""
    @State var resultLabel2 : String = ""
    
    @State var longitude : String = ""
    @State var latitude : String = ""
    
    // Initialize region with default coordinates
      @State var region: MKCoordinateRegion = MKCoordinateRegion(
          center: CLLocationCoordinate2D(latitude: 43.0832, longitude: -80.1419),
          span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
      )
  
    var body: some View {
        VStack {
            Text("GeoLocation Demo")
                .font(.title)
                .fontWeight(.bold)
            TextField("Enter an address...", text:$addr)
                .padding(10)
                .border(.gray, width:2)
                .cornerRadius(3)
            
            Button("Forward Geocoding"){
                let geocoder: CLGeocoder = CLGeocoder()
                
                geocoder.geocodeAddressString(addr){
                    (placemarks, error) in
                    
                    if error != nil {
                        resultLabel = "No Matching Location Found!"
                    }
                    else {
                        let result = placemarks![0]
                        let location : CLLocation = result.location!
                        latitude = String(location.coordinate.latitude)
                        longitude = String(location.coordinate.longitude)

                        resultLabel = "Matching location found at: \(location.coordinate.latitude), \(location.coordinate.longitude)"
                        
                        withAnimation{
                            region.center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        }
                        
                    }
                }
            }
            .padding()
            .foregroundStyle(.white)
            .background(.black)
            .cornerRadius(8)
            
            
            Text("\(resultLabel)").padding(12)
            
            
       
            TextField("Enter an Latitude...", text:$latitude)
                .padding(10)
                .border(.gray, width:2)
                .cornerRadius(3)
            TextField("Enter an Longitude...", text:$longitude)
                .padding(10)
                .border(.gray, width:2)
                .cornerRadius(3)
            
            Button("Reverse Geocoding"){
                let geocoder: CLGeocoder = CLGeocoder()
                let coordinateToSearch : CLLocation = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
                
                geocoder.reverseGeocodeLocation(coordinateToSearch){
                    (placemarks, error) in
                    
                    if error != nil {
                        resultLabel2 = "No Matching Location Found!"
                    }
                    else {
                        let result: CLPlacemark = placemarks![0]
                        
                        
                        resultLabel2 = "Matching location found at:\(result.subThoroughfare ?? "NA"), \(result.thoroughfare ?? "NA"),\(result.subLocality ?? "NA"), \(result.locality ?? "NA"), \(result.administrativeArea ?? "NA"), \(result.postalCode ?? "NA"), \(result.country ?? "NA")"
                       
                    }
                }
            }
            .padding()
            .foregroundStyle(.white)
            .background(.black)
            .cornerRadius(8)
            
            
            Text("\(resultLabel2)").padding(12)
            
            Map(coordinateRegion: $region, annotationItems: [region.center]) { location in
                            MapMarker(coordinate: location, tint: .red)
                        }
                .padding()
            Spacer()
        }
        .padding()
    }
}
extension CLLocationCoordinate2D: @retroactive Identifiable {
    public var id: String {
        "\(latitude),\(longitude)"
    }
}

#Preview {
    ContentView()
}

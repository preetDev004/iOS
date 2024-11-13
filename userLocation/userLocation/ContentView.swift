//
//  ContentView.swift
//  userLocation
//
//  Created by Preet Patel on 13/11/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    @Bindable var helper = UserLocationHelper()
    @State var msg:String = "message goes here"

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 57, longitude: 9), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    @State private var userTrackingMode: MapUserTrackingMode = .follow
  
        
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Get Location"){
                if (helper.userLocation != nil){
                    print("Got Locations!!!")
                    region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: helper.userLocation!.coordinate.latitude, longitude: helper.userLocation!.coordinate.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                }
                
                

            }
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .border(.gray, width: 1)
            .cornerRadius(4)
            
            
            Map(coordinateRegion: $region, userTrackingMode: $userTrackingMode)
               
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

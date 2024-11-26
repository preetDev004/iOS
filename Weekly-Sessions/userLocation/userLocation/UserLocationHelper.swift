//
//  UserLocationHelper.swift
//  userLocation
//
//  Created by Preet Patel on 13/11/24.
//

import CoreLocation

@Observable
class UserLocationHelper: NSObject, CLLocationManagerDelegate{
    
    var manager = CLLocationManager()
    // used to broadcast the user's location to the UI
    var userLocation: CLLocation? = nil
    
    override init(){
        super.init()
        manager.delegate = self
        
        let status = manager.authorizationStatus
        
        if status == .notDetermined{
            print("DEBUG: Permission status: unknown")

        } else if (status == .denied || status == .restricted){
            print("DEBUG: Permission status: restricted or denied")

        } else if (status == .authorizedAlways || status == .authorizedWhenInUse){
            print("DEBUG: Permission status:  granted")

        }
        
        manager.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(_manager: CLLocationManager, didUpdateLocations locations: [CLLocation] ){
        if (locations.isEmpty){
            return
        }
        self.userLocation = locations[0]
        print("Location found: \(self.userLocation!.coordinate)")
        print("Altitude: \(self.userLocation!.altitude)")
        print("Speed: \(self.userLocation!.speed)")
        print("Time location obtained: \(self.userLocation!.timestamp)")
        print("Direction of travel: \(self.userLocation!.course)")
    }
     func locationManager(_manager: CLLocationManager, didFailWithError error: Error ){
         print(error.localizedDescription)
    }
    
    
    
    
    
}

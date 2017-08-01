//
//  PGLocationManager.swift
//  TimerTableCell
//
//  Created by pradip gotamay on 7/31/17.
//  Copyright © 2017 Pradip Gotame. All rights reserved.
//

import UIKit
import CoreLocation

enum LocationStrength {
   case LocationStrengthGone
   case LocationStrengthPoor
   case LocationStrengthAverage
   case LocationStrengthStrong
}

protocol PGLocationManageDelegate {
    func getWayPoints(locationManager : PGLocationManager, waypoints : CLLocation) -> Void
    func locationError(locationManager : PGLocationManager, error:Error) -> Void
}

class PGLocationManager: NSObject, CLLocationManagerDelegate{
    
    var delegate : PGLocationManageDelegate!
    
    var locationStrength : LocationStrength?
    
    private var locationManager = CLLocationManager()
    
    static let sharedInstances = PGLocationManager()
    
    var locationTimer : Timer!
    
    private override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.delegate = self
            self.locationManager.distanceFilter  = CLLocationDistance(Constant.IntValue.kDistanceFilter.rawValue)
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.activityType    = CLActivityType.automotiveNavigation
            self.locationManager.pausesLocationUpdatesAutomatically = false
        }
    }
    
    func startLocationUpdate() -> Void {
        let locationStatus : CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        if locationStatus == .denied{
            
        }else{
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func stopLocationUpdate() -> Void {
        self.locationTimer.invalidate()
        self.locationManager.stopUpdatingLocation()
    }
    
    func pingForNewLocation() -> Void{
        stopLocationUpdate()
        startLocationUpdate()
    }
    
    //location manager delegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mostRecentLocation : CLLocation = locations.last!
        
        if self.locationTimer != nil{
            self.locationTimer.invalidate()
        }
        
        self.delegate?.getWayPoints(locationManager: self, waypoints: mostRecentLocation)
        
        self.locationTimer = Timer.scheduledTimer(timeInterval: TimeInterval(Constant.IntValue.kMinimumLocationUpdateInterVal.rawValue), target: self, selector: #selector(pingForNewLocation), userInfo: nil, repeats: true)
        RunLoop.main.add(self.locationTimer, forMode: .commonModes)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.locationError(locationManager: self, error: error)
        AppManager.showLog(message: "error \(error)")
        stopLocationUpdate()
    }

}

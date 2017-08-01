//
//  ViewController.swift
//  TimerTableCell
//
//  Created by pradip gotamay on 7/31/17.
//  Copyright © 2017 Pradip Gotame. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, PGLocationManageDelegate, TimeFormatProtocol {
    
    @IBOutlet weak var btn_locationTrack: UIButton!
    @IBOutlet weak var view_container: UIView!
    @IBOutlet weak var lbl_timer: UILabel!
    @IBOutlet weak var lbl_distance: UILabel!
    
    var timer_timeSpend : Timer!
   
    var lastRecordedLocation: CLLocation!
    var startLocation : CLLocation!
//    var travelledDistance : Float = 0.0
    
    var sec : Int = 0
    var min : Int = 0
    var hrs : Int = 0
    
    var str_ellapsedTime : String!
    var str_sec : String!
    var str_min : String!
    var str_hrs : String!
    
    var flagForLocationEnable : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideUnhideContainerView(flag: true)
        AppManager.addSlideAnimationOn(view: self.view_container, flag: true)
    }

    @IBAction func btn_locationTrack(_ sender: Any) {
        
        self.flagForLocationEnable = true
        
        startUserLocationUpdate()
        
        hideUnhideContainerView(flag: false)

        self.timer_timeSpend = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showTimer), userInfo: nil, repeats: true)
        AppManager.addSlideAnimationOn(view: self.view_container, flag: false)
    }
    
    
    
    
    /*Pragma :::: PGLocationManager delegates*/
    func getWayPoints(locationManager: PGLocationManager, waypoints: CLLocation) {
        
        var travelledDistance : Float = 0.0
        
        (self.startLocation == nil) ? (self.startLocation = waypoints) : (travelledDistance = Float((self.lastRecordedLocation?.distance(from: self.startLocation))!))

        if self.lastRecordedLocation != nil{
            if travelledDistance >= 200 && travelledDistance <= 250{
                
                timer_timeSpend.invalidate()
                
                AppManager.showAlertView(alertTitle: (Constant.StringValue.EMPTY_TITLE.rawValue), alertMessage: (Constant.StringValue.kMessage_DistanceCovered.rawValue), delegate: nil)
                
                stopUserLocationUpdate()
            }else{
                self.lbl_distance.text = "Travelled Distance : \(travelledDistance)"
            }
        }
        
        self.lastRecordedLocation = waypoints
    }
    
    func locationError(locationManager: PGLocationManager, error: Error) {
        AppManager.showAlertView(alertTitle: (Constant.StringValue.EMPTY_TITLE.rawValue), alertMessage: (Constant.StringValue.kErrorMessage_LocationError.rawValue), delegate: nil)
    }
    /*end of location manager delegates*/
    
    /*Pragma :::: segue method*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == Constant.StringValue.kSegueId_TimerCellBtn.rawValue{
            if self.flagForLocationEnable{
                
                self.flagForLocationEnable = false
                AppManager.addSlideAnimationOn(view: self.view_container, flag: true)
                
                stopUserLocationUpdate()
                self.timer_timeSpend.invalidate()
            }
            _ = segue.destination as! MainVC
        }
    }
    /*end of segue*/
    
    /*custom methods*/
    func stopUserLocationUpdate() -> Void {
        PGLocationManager.sharedInstances.delegate = nil
        PGLocationManager.sharedInstances.stopLocationUpdate()
    }
    
    func startUserLocationUpdate() -> Void {
        PGLocationManager.sharedInstances.delegate = self
        PGLocationManager.sharedInstances.startLocationUpdate()
    }

    func hideUnhideContainerView(flag: Bool) -> Void{
        if flag{
            self.view_container.isHidden = flag
            
            (self.timer_timeSpend != nil) ? (self.timer_timeSpend.invalidate()) : (AppManager.showLog(message: Constant.StringValue.EMPTY_TITLE.rawValue))
            
        }else{
            self.view_container.isHidden = flag
        }
    }
    
    /*methods for showing ellapse time in label*/
    func showTimer() -> Void{
        if self.sec < 59 && self.min == 0 && self.hrs == 0{
            self.sec += 1
        }else{
            if self.sec == 59 && (self.min >= 0 && self.min < 59) && self.hrs == 0 {
                self.min += 1;
                self.sec = 0;
            }else{
                if(self.min == 59 && (self.hrs >= 0 && self.hrs < 59)){
                    self.min = 0;
                    self.sec = 0;
                    self.hrs  += 1;
                    
                }else{
                    if (self.min >= 0 && self.min < 59){
                        if(self.sec == 59){
                            self.sec = 0;
                            self.min += 1;
                        }else{
                            self.sec += 1;
                        }
                    }else{
                        self.timer_timeSpend.invalidate()
                    }
                    
                }
            }
        }
        
        self.lbl_timer.text = getTimes()
    }
    
    /*time format protocol*/
    func getTimes() -> String{
        (self.sec == 0) ? (self.str_sec = String(format:"0%d",self.sec)) : (self.str_sec = String(format:"%d",self.sec))
        (self.min == 0) ? (self.str_min = String(format:"0%d",self.min)) : (self.str_min = String(format:"%d",self.min))
        (self.hrs == 0) ? (self.str_hrs = String(format:"0%d",self.hrs)) : (self.str_hrs = String(format:"%d",self.hrs))
     
        self.str_ellapsedTime = String(format:"%@h : %@m : %@s",self.str_hrs, self.str_min, self.str_sec)
        
        return self.str_ellapsedTime
    }
}


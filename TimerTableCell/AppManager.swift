//
//  AppManager.swift
//  TimerTableCell
//
//  Created by pradip gotamay on 7/31/17.
//  Copyright © 2017 Pradip Gotame. All rights reserved.
//

import UIKit



class AppManager: NSObject {
    
    class func addSlideAnimationOn(view: UIView, flag:Bool) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type     = kCATransitionPush
        
        if flag{
            transition.subtype  = kCATransitionFromBottom
        }else{
            transition.subtype  = kCATransitionFromTop
        }
        
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    class func showAlertView(alertTitle : String , alertMessage : String, delegate: UIViewController?) -> Void{
        let alert = UIAlertController(title: alertTitle as String, message: alertMessage as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        delegate?.present(alert, animated: true, completion: nil)
    }
    
    class func showLog(message: String) -> Void {
        print("TTC ::: \(message)")
    }
    
    class func getDateFormat() -> DateFormatter{
        let dateFormater : DateFormatter = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormater
    }
}

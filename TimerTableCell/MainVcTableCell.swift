//
//  MainVcTableCell.swift
//  TimerTableCell
//
//  Created by pradip gotamay on 8/1/17.
//  Copyright © 2017 Pradip Gotame. All rights reserved.
//

import UIKit

class MainVcTableCell: UITableViewCell{
    
    var timer : Timer!
    
    var flagForTimerStart : Bool!
    
    
    @IBOutlet weak var lbl_timer: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func stopTimer() -> Void{
        (self.timer != nil) ? (self.timer.invalidate()) : (AppManager.showLog(message: Constant.StringValue.EMPTY_TITLE.rawValue))
    }
    
    func startTimerWith(time:String) -> Void{
        
        self.stopTimer()
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showTimer(_:)), userInfo: time, repeats: true)
        
        RunLoop.main.add(self.timer, forMode: .commonModes)
        
    }

    func showTimer(_ timerInstance: Timer) -> Void{
        
        let timerInfo   = timerInstance.userInfo as! String
        
        let currentDate = Date()
        
        let currentDateInString   = AppManager.getDateFormat().string(from: currentDate) as String
        
        let currentDateInDateFormat   = AppManager.getDateFormat().date(from: currentDateInString)!
        let comparingDateInDateFormat = AppManager.getDateFormat().date(from: timerInfo)!
        
        
        
        let unitFlags = Set<Calendar.Component>([.day, .hour, .minute, .second])
        
        let components = NSCalendar.current.dateComponents(unitFlags, from: currentDateInDateFormat, to: comparingDateInDateFormat)
        

                
        if components.hour! == 0 && components.minute! == 0 && components.second! == 0{
            self.timer.invalidate()
        }
     
        self.lbl_timer.text = String(format:"%dd:%dh:%dm:%d:S",components.day!,components.hour!,components.minute!,components.second!)
     
    }
    
    
}

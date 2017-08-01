//
//  Constant.swift
//  TimerTableCell
//
//  Created by pradip gotamay on 8/1/17.
//  Copyright © 2017 Pradip Gotame. All rights reserved.
//

import UIKit

class Constant: NSObject {
    enum IntValue : Int{
        case kDistanceFilter = 5
        case kMinimumLocationUpdateInterVal = 1
        case kHorizontalAccuracyPoorSignalValue = 163
        case kHorizontalAccuracyAverageSignalValue = 48
        case kMinimumTravelDistance = 200
        case kMaximumTravelDistance = 250
    }
    
    enum StringValue : String{
        case EMPTY_TITLE = ""
        case kMessage_DistanceCovered = "Congratulation You have travelled more than 200m"
        case kErrorMessage_LocationError = "Error Occured while retriving location"
        
        case kSegueId_TimerCellBtn = "segue_timerCell"
        
        case kIdentifier_TableCell_MainVCTC = "MainVcTableCell"
    }
}

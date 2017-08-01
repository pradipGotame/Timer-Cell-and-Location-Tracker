//
//  MainVC.swift
//  TimerTableCell
//
//  Created by pradip gotamay on 8/1/17.
//  Copyright © 2017 Pradip Gotame. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var array_date = NSArray(objects: "2017-9-23 12:12:2", "2017-10-20 10:10:12", "2017-11-24 11:11:11","2017-12-24 10:10:16","2017-9-23 12:12:2", "2017-10-20 10:10:12", "2017-11-24 11:11:11","2017-12-24 10:10:16","2017-9-23 12:12:2", "2017-10-20 10:10:12", "2017-11-24 11:11:11","2017-12-24 10:10:16")
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//TABLE VIEW DELEGATES
extension MainVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.array_date.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.StringValue.kIdentifier_TableCell_MainVCTC.rawValue, for: indexPath) as! MainVcTableCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let str_date = self.array_date.object(at: indexPath.row) as! String
        
        (cell as! MainVcTableCell).flagForTimerStart = false
        (cell as! MainVcTableCell).startTimerWith(time: str_date)
    }
    
}

extension MainVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


//
//  insideViewController.swift
//  FitTrack
//
//  Created by Mats Bauer on 22.04.18.
//  Copyright © 2018 Mats Bauer. All rights reserved.
//

import UIKit
import Alamofire

class insideViewController: UIViewController {
    let userid = defaults.integer(forKey: "userid")
    
    @IBOutlet weak var labelUserid: UILabel!
    @IBOutlet weak var labelNexttraining: UILabel!
    @IBOutlet weak var labelLasttraining: UILabel!
    @IBOutlet weak var labelninetydays: UILabel!
    @IBOutlet weak var labelAllchange: UILabel!
    @IBOutlet weak var labelthirtydays: UILabel!
    @IBOutlet weak var labelManual: UITextField!
    @IBOutlet weak var labelFP: UILabel!
    @IBOutlet weak var labelLastTrainingChange: UILabel!
    
    @IBAction func insertManual(_ sender: UIButton) {
        let machinecode = labelManual.text
        defaults.set(machinecode, forKey: "machinecode")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelUserid.text = "ID: " + String(userid) + ""
        
        // GET LAST TRAINING DATE
        let loginurl = "https://makethemostof500.com/FitTrack/checklasttraining.php?userid=" + String(userid) + ""
        
        Alamofire.request(loginurl, method: .get).responseJSON
            {
                response in
                print(response)
                
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    self.labelLasttraining.text = jsonData.value(forKey: "result") as! String?
                    self.labelNexttraining.text = jsonData.value(forKey: "nextdate") as! String?
                    self.labelFP.text = jsonData.value(forKey: "fp") as! String?
                }
        }
        
        // GET PERFORMANCE VALUES
        let performanceurl = "https://makethemostof500.com/FitTrack/performance.php?userid=" + String(userid) + ""
        
        Alamofire.request(performanceurl, method: .get).responseJSON
            {
                response in
                print(response)
                
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    self.labelthirtydays.text = jsonData.value(forKey: "30daychange") as! String?
                    self.labelninetydays.text = jsonData.value(forKey: "90daychange") as! String?
                    self.labelAllchange.text = jsonData.value(forKey: "allchange") as! String?
                    self.labelLastTrainingChange.text = jsonData.value(forKey: "last") as! String?
                }
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

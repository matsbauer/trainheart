//
//  MachineViewController.swift
//  FitTrack
//
//  Created by Mats Bauer on 22.04.18.
//  Copyright © 2018 Mats Bauer. All rights reserved.
//

import UIKit
import Alamofire

class MachineViewController: UIViewController {

    @IBOutlet weak var labelMachine: UILabel!
    @IBOutlet weak var labelBestResult: UILabel!
    @IBOutlet weak var labelBestReps: UILabel!
    @IBOutlet weak var labelLastdate: UILabel!
    @IBOutlet weak var labelCurrentreps: UILabel!
    @IBOutlet weak var labelCurrentweight: UILabel!
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelRegion: UILabel!
    
    @IBAction func button25kg(_ sender: UIButton) {
        self.labelCurrentweight.text = "25"
    }

    @IBAction func button100kg(_ sender: UIButton) {
        self.labelCurrentweight.text = "100"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userid = defaults.integer(forKey: "userid")
        let machineid = defaults.integer(forKey: "machinecode")
        self.labelMachine.text = String(machineid)
        self.labelCode.text = String(machineid)
        
        let loginurl = "https://makethemostof500.com/FitTrack/getmachine.php?machineid=" + String(machineid)
        
        Alamofire.request(loginurl, method: .get).responseJSON
            {
                response in
                print(response)
                
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    self.labelMachine.text = (jsonData.value(forKey: "result") as! String?)?.replacingOccurrences(of: "ue", with: "ü")
                    
                    self.labelRegion.text = (jsonData.value(forKey: "region") as! String?)?.replacingOccurrences(of: "ue", with: "ü")
                }
        }
        
        let performance = "https://makethemostof500.com/FitTrack/machineperformance.php?machineid=" + String(machineid) + "&userid=" + String(userid)
        
        Alamofire.request(performance, method: .get).responseJSON
            {
                response in
                print(response)
                
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    let maxweight = jsonData.value(forKey: "maxweight") as! String?
                    let maxreps = jsonData.value(forKey: "withthisrep") as! String?
                    let lasttraining = jsonData.value(forKey: "lasttraining") as! String?
                    
                    if((maxweight ?? "").isEmpty){
                        self.labelBestResult.text = "-"
                        self.labelCurrentweight.text = "20"
                    }
                    else{
                        self.labelBestResult.text = maxweight
                        self.labelCurrentweight.text = maxweight
                    }
                    
                    if((maxreps ?? "").isEmpty){
                        self.labelBestReps.text = "-"
                        self.labelCurrentreps.text = "8"
                    }
                    else{
                        self.labelBestReps.text = maxreps
                        self.labelCurrentreps.text = maxreps
                    }
                    
                    if((lasttraining ?? "").isEmpty){
                        self.labelLastdate.text = "-"
                    }
                    else{
                        self.labelLastdate.text = lasttraining
                    }
                }
        }
        
    }
    
    @IBAction func buttonInc(_ sender: UIButton) {
        self.labelCurrentreps.text = String(Int(labelCurrentreps.text!)! + 1)
        if Int(self.labelCurrentreps.text!)! > 15 || Int(self.labelCurrentreps.text!)! < 8{
            self.labelCurrentreps.textColor = UIColor.red
        }
        else{
            self.labelCurrentreps.textColor = UIColor.black
        }
    }
    
    @IBAction func buttonDec(_ sender: UIButton) {
        self.labelCurrentreps.text = String(Int(labelCurrentreps.text!)! - 1)
        if Int(self.labelCurrentreps.text!)! < 8 || Int(self.labelCurrentreps.text!)! > 15 {
            self.labelCurrentreps.textColor = UIColor.red
        }
        else{
            self.labelCurrentreps.textColor = UIColor.black
        }
    }
    
    @IBAction func buttonWeightInc(_ sender: UIButton) {
        self.labelCurrentweight.text = String(Double(labelCurrentweight.text!)! + 0.5)
    }
    
    @IBAction func buttonWeightDec(_ sender: UIButton) {
        self.labelCurrentweight.text = String(Double(labelCurrentweight.text!)! - 0.5)
    }
    
    @IBAction func setEigengewicht(_ sender: UIButton) {
        let weight = defaults.integer(forKey: "weight")
        if(weight > 0){
            self.labelCurrentweight.text = String(weight)
        }
        else{
            self.labelCurrentweight.text = "60"
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonUploadData(_ sender: UIButton) {
        let userid = defaults.integer(forKey: "userid")
        let machid = defaults.integer(forKey: "machinecode")
        let upload = "https://makethemostof500.com/FitTrack/uploadperformance.php?machineid=" + String(machid) + "&userid=" + String(userid) + "&reps=" + String(Int(labelCurrentreps.text!)!) + "&weight=" + String(Double(labelCurrentweight.text!)!)
        
        Alamofire.request(upload, method: .get).responseJSON
            {
                response in
                print(response)
        }
    }
    

}

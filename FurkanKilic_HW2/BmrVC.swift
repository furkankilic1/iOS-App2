//
//  BmrVC.swift
//  FurkanKilic_HW2
//
//  Created by CTIS Student on 18.11.2021.
//  Copyright © 2021 CTIS. All rights reserved.
//

import UIKit

class BmrVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var heightTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var activityPickerView: UIPickerView!
    @IBOutlet weak var mSlider: UISlider!
    @IBOutlet weak var mSwitch: UISwitch!
    
    var getGender = "Male"
    var typeMultipliers = 1.0
    var age = 20
    var resultWeight = 0.0
    var resultHeight = 0.0
    var resultBMR = 0.0
    
    var plistArray: NSMutableArray = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of items/rows in the components
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plistArray.count
    }
    
    // Called automatically multiple times. To attach the data
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (plistArray[row] as! String)
    }
    
    // Called when an item in pickerView is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.view.endEditing(true)
        
        switch row {
            case 1:
                typeMultipliers = 1.375
            case 2:
                typeMultipliers = 1.55
            case 3:
                typeMultipliers = 1.725
            case 4:
                typeMultipliers = 1.9
            default:
                typeMultipliers = 1.0
        }
        
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        self.view.endEditing(true)
        age = Int(mSlider.value)
        ageLabel.text = "AGE (" + String(age) + ")"
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if mSwitch.isOn {
            genderLabel.text = "Gender (Male)"
            getGender = "Male"
        }
        else {
            genderLabel.text = "Gender (Female)"
            getGender = "Female"
        }
    }
    
    @IBAction func calculateAction(_ sender: Any) {
        self.view.endEditing(true)
        
        resultBMR = 0.0
        
        if !(heightTF.text!.isEmpty || weightTF.text!.isEmpty) {
            resultWeight = Double(weightTF.text!)!
            resultHeight = Double(heightTF.text!)!
            
            resultBMR = (10.0 * resultWeight) + (6.25 * resultHeight) - (5.0 * Double(age))
            
            if getGender == "Male" {
                resultBMR += 5.0
            }
            else {
                resultBMR -= 161.0
            }
            
            resultBMR *= typeMultipliers
    
        }
        
        let mAlert = UIAlertController(title: "BMR Result", message: "BMR(" + getGender + ", " + String(age) + " Years = " + String(resultBMR) , preferredStyle: .alert)
        mAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(mAlert, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageLabel.text = "AGE (20)"
        
        let bundle = Bundle.main
        
        if let url = bundle.url(forResource: "types", withExtension: "plist") {
            plistArray = NSMutableArray(contentsOf: url)!
        }
        
    }
    
}

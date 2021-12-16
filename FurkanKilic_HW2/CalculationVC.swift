//
//  CalculationVC.swift
//  FurkanKilic_HW2
//
//  Created by CTIS Student on 17.11.2021.
//  Copyright © 2021 CTIS. All rights reserved.
//

import UIKit

class CalculationVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, InputVCDelegate {
    
    @IBOutlet weak var mPickerView: UIPickerView!
    @IBOutlet weak var mImage: UIImageView!
    
    var area = 0.0
    var perimeter = 0.0
    var hypotenuse = 0.0
    var typeName = ""
    
    let shapes = ["Triangle", "Circle", "Rectangle"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of items/rows in the components
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shapes.count
    }
    
    // Called automatically multiple times. To attach the data
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shapes[row]
    }
    
    // Called when an item in pickerView is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch row {
            case 1:
                mImage.image = UIImage(named: "circle")
            case 2:
                mImage.image = UIImage(named: "rectangle")
            default:
                mImage.image = UIImage(named: "triangle")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let VC = segue.destination as? InputVC {
            
            switch mPickerView.selectedRow(inComponent: 0) {
                case 1:
                    VC.labelStr1 = "Radius:"
                    VC.index = 1
                    VC.delegate = self
                case 2:
                    VC.labelStr1 = "Length:"
                    VC.labelStr2 = "Widht:"
                    VC.index = 2
                    VC.delegate = self
                default:
                    VC.labelStr1 = "Base:"
                    VC.labelStr2 = "Height:"
                    VC.index = 0
                    VC.delegate = self
            }
            
        }
        
    }
    
    func resultData(data: (Double, Double, Int)) {
        let (valueTF1, valueTF2, valueType) = data
        
        if valueType == 0 {
            area = (valueTF1 * valueTF2) / 2
            hypotenuse = pow( (valueTF1 * valueTF1) + (valueTF2 * valueTF2), 1/2)
            perimeter = valueTF1 + valueTF2 + hypotenuse
            typeName = "Triangle"
        }
        else if valueType == 1 {
            perimeter = Double.pi * valueTF1 * 2
            area = Double.pi * valueTF1 * valueTF1
            typeName = "Circle"
        }
        else if valueType == 2 {
            perimeter = 2 * (valueTF1 + valueTF2)
            area = valueTF1 * valueTF2
            typeName = "Rectangle"
        }
        
        let areaStr = String(format:"%0.2f", area)
        let perimeterStr = String(format:"%0.2f", perimeter)
        
        let mAlert = UIAlertController(title: "Result", message: typeName + " Perimeter = " + perimeterStr + "\n" + typeName + " Area = " + areaStr, preferredStyle: .alert)
        mAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(mAlert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

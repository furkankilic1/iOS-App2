//
//  InputVC.swift
//  FurkanKilic_HW2
//
//  Created by CTIS Student on 19.11.2021.
//  Copyright © 2021 CTIS. All rights reserved.
//

import UIKit

protocol InputVCDelegate {
    func resultData(data: (Double, Double, Int))
}

class InputVC: UIViewController {

    @IBOutlet weak var mTextField1: UITextField!
    @IBOutlet weak var mTextField2: UITextField!
    @IBOutlet weak var mLabel1: UILabel!
    @IBOutlet weak var mLabel2: UILabel!
    
    var delegate: InputVCDelegate?
    var labelStr1 = ""
    var labelStr2 = ""
    var index = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        
        if ( (index == 1 && !mTextField1.text!.isEmpty) || ((index == 0 || index == 2) && !mTextField1.text!.isEmpty && !mTextField2.text!.isEmpty )){
            let valueTextField1 = Double(mTextField1.text!)!
            var valueTextField2 = 0.0
            
            if !mTextField2.text!.isEmpty {
                valueTextField2 = Double(mTextField2.text!)!
            }
            
            self.navigationController?.popViewController(animated: true)
            delegate?.resultData(data: (valueTextField1, valueTextField2, index ))
        }
        else {
            let mAlert = UIAlertController(title: "Error", message: "Data cannot be empty", preferredStyle: .alert)
            mAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(mAlert, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mLabel1.text = labelStr1
        mLabel2.text = labelStr2

        switch index {
            case 1:
                mTextField1.placeholder = "Enter radius value"
                mTextField2.isHidden = true
                mLabel2.isHidden = true
                self.title = "Circle"
            case 2:
                mTextField1.placeholder = "Enter length value"
                mTextField2.placeholder = "Enter width value"
                self.title = "Rectangle"
            default:
                mTextField1.placeholder = "Enter base value"
                mTextField2.placeholder = "Enter height value"
                self.title = "Triangle"
        }
        
    }

}

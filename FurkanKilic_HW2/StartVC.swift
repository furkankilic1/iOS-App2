//
//  StartVC.swift
//  FurkanKilic_HW2
//
//  Created by CTIS Student on 17.11.2021.
//  Copyright © 2021 CTIS. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var mSegmentedControl: UISegmentedControl!
    var curentSelection = 0
    
    
    @IBAction func mSegmentAction(_ sender: Any) {
        
        switch mSegmentedControl.selectedSegmentIndex {
            case 1:
                mLabel.text = "BMR Controller"
                mImage.image = UIImage(named: "bmr")
                curentSelection = 1
            case 2:
                mLabel.text = "Player Controller"
                mImage.image = UIImage(named: "players")
                curentSelection = 2
            case 3:
                mLabel.text = "Chart Controller"
                mImage.image = UIImage(named: "chart")
                curentSelection = 3
            default:
                mLabel.text = "Calculation Controller"
                mImage.image = UIImage(named: "calculation")
                curentSelection = 0
        }
        
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        if curentSelection == 0 {
            mLabel.text = "BMR Controller"
            mImage.image = UIImage(named: "bmr")
            mSegmentedControl.selectedSegmentIndex = 1
            curentSelection = 1
        }
        else if curentSelection == 1 {
            mLabel.text = "Player Controller"
            mImage.image = UIImage(named: "players")
            mSegmentedControl.selectedSegmentIndex = 2
            curentSelection = 2
        }
        else if curentSelection == 2 {
            mLabel.text = "Chart Controller"
            mImage.image = UIImage(named: "chart")
            mSegmentedControl.selectedSegmentIndex = 3
            curentSelection = 3
        }
        else if curentSelection == 3 {
            mLabel.text = "Calculation Controller"
            mImage.image = UIImage(named: "calculation")
            mSegmentedControl.selectedSegmentIndex = 0
            curentSelection = 0
        }

    }
    
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        if curentSelection == 0 {
            performSegue(withIdentifier: "calculationID" , sender: self)
        }
        else if curentSelection == 1 {
            performSegue(withIdentifier: "bmrID" , sender: self)
        }
        else if curentSelection == 2 {
            performSegue(withIdentifier: "playerID" , sender: self)
        }
        else if curentSelection == 3 {
            performSegue(withIdentifier: "chartID" , sender: self)
        }
        
    }
    
    @IBAction func unwindToStartVC(_ unwindSegue: UIStoryboardSegue) {
        _ = unwindSegue.source
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        mImage.isUserInteractionEnabled = true
        mImage.addGestureRecognizer(tapGestureRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        mImage.addGestureRecognizer(longPressRecognizer)
    }

}


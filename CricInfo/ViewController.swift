//
//  ViewController.swift
//  CricInfo
//
//  Created by bjit on 8/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
       print("current date start time \(Utilities.shared.getDayStartTime(at: Date()))")
    }
}


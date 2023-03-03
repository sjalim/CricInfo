//
//  DatePickerViewController.swift
//  CricInfo
//
//  Created by bjit on 20/2/23.
//

import UIKit

protocol DataPickerDelegate {
    func passDateBack(date: Date)
}


class DatePickerViewController: UIViewController {
    
    var delegate: DataPickerDelegate?

    
    @IBOutlet weak var datePicketContainerView: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.preferredDatePickerStyle = .inline
        
        datePicker.datePickerMode = .date
        datePicketContainerView.layer.cornerRadius = 20
        let blurEffect = UIBlurEffect(style: .regular)
                let blurView = UIVisualEffectView(effect: blurEffect)
                blurView.frame = datePicketContainerView.bounds
                blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
        blurView.layer.cornerRadius = 20
        datePicketContainerView.backgroundColor = .clear
        datePicketContainerView.addSubview(blurView)
        datePicketContainerView.sendSubviewToBack(blurView)
    }
    

    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        
        print("selected date:", sender.date)
        
        delegate?.passDateBack(date: sender.date)
        
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        
        
        self.dismiss(animated: true)
    }
    
}

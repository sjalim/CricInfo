//
//  CustomAlertViewController.swift
//  CricInfo
//
//  Created by bjit on 24/2/23.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    
    static let shared = CustomAlertViewController()
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
           hide()
       }
    private init() {
        super.init(nibName: "CustomAlertViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        
    }
    
    private func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.7)
        self.backView.alpha = 0
        self.containerView.alpha = 0
        self.containerView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 1, delay: 0.2) {
            self.backView.alpha = 1
            self.containerView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.containerView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    
    
    
}

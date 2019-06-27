//
//  ViewControllerExtention.swift
//  Cubee
//
//  Created by Grzegorz Jaworski on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func updateUI() {
        //mode
        let chosenMode = UserDefaults.standard.string(forKey: "Theme")
        
        //labels
        let labels = self.view.subviews.compactMap { $0 as? UILabel }
        for label in labels {
            if chosenMode == "Light mode" {
                label.textColor = .black
            }
            
            if chosenMode == "Dark mode" {
                label.textColor = .white
            }
        }
        
        //buttons
        let buttons = self.view.subviews.compactMap { $0 as? UIButton }
        for button in buttons {
            if chosenMode == "Light mode" {
                button.backgroundColor = .black
            }
            
            if chosenMode == "Dark mode" {
                button.backgroundColor = .white
            }
        }
        
        //background
        if chosenMode == "Light mode" {
            self.view.backgroundColor = .white
        }
        
        if chosenMode == "Dark mode" {
            self.view.backgroundColor = .darkGray
        }
    }
}

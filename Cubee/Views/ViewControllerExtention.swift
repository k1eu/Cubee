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
        let chosenMode = UserDefaults.standard.string(forKey: "theme")
        
        //labels
        let labels = getLabelsInView(view: self.view)
        print(labels)
        for label in labels {
            if chosenMode == "light" {
                label.textColor = .black
            }
            
            if chosenMode == "dark" {
                label.textColor = .white
            }
        }
        
        //buttons
        let buttons = getButtonsInView(view: self.view)
        print(buttons)
        for button in buttons {
            if chosenMode == "light" {
                button.backgroundColor = .none
                button.setTitleColor(.blue, for: .normal)
            }
            
            if chosenMode == "dark" {
                button.backgroundColor = .black
                button.setTitleColor(.white, for: .normal)
            }
        }
        
        //segmented
        let segmenteds = getSegmentedsInView(view: self.view)
        print(buttons)
        for segmented in segmenteds {
            if chosenMode == "light" {
                segmented.tintColor = .blue
            }
            
            if chosenMode == "dark" {
                segmented.tintColor = .white
            }
        }
        
        //background
        if chosenMode == "light" {
            self.view.backgroundColor = .white
        }
        
        if chosenMode == "dark" {
            self.view.backgroundColor = .darkGray
        }
    }
    
    func getLabelsInView(view: UIView) -> [UILabel] {
        var results = [UILabel]()
        
        for subview in view.subviews as [UIView] {
            if let labelView = subview as? UILabel {
                results += [labelView]
            } else {
                results += getLabelsInView(view: subview)
            }
        }
        return results
    }
    
    func getButtonsInView(view: UIView) -> [UIButton] {
        var results = [UIButton]()
        
        for subview in view.subviews as [UIView] {
            if let labelView = subview as? UIButton {
                results += [labelView]
            } else {
                results += getButtonsInView(view: subview)
            }
        }
        return results
    }
    
    func getSegmentedsInView(view: UIView) -> [UISegmentedControl] {
        var results = [UISegmentedControl]()
        
        for subview in view.subviews as [UIView] {
            if let labelView = subview as? UISegmentedControl {
                results += [labelView]
            } else {
                results += getSegmentedsInView(view: subview)
            }
        }
        return results
    }
}

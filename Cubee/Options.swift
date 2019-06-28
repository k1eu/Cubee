//
//  Options.swift
//  Cubee
//
//  Created by Tomasz Kielar on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class Options : UIViewController {
    
    //Variables and Constants
    let defaults = UserDefaults.standard
    
    //Outlets
    @IBOutlet weak var nickTextfield: UITextField!
    @IBOutlet weak var avgSegmentedControll: UISegmentedControl!
    @IBOutlet weak var themeSegmentedControll: UISegmentedControl!
    @IBOutlet weak var submitButton: UIButton!
    
    //View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        setThemeSegmented()
    }
    
    //Actions
    @IBAction func nickChanged(_ sender: Any) {
        let newNick = nickTextfield.text
        defaults.set(newNick, forKey: "nick")
    }
    
    @IBAction func avgControllValueChanged(_ sender: UISegmentedControl) {
        let selectedSegment = sender.selectedSegmentIndex
        let newOption = sender.titleForSegment(at: selectedSegment)
        
        defaults.set(newOption, forKey: "avg")
    }
    
    @IBAction func themeControllValueChanged(_ sender: UISegmentedControl) {
        let selectedSegment = sender.selectedSegmentIndex
        let selectedOption = sender.titleForSegment(at: selectedSegment)
        var newOption = String()
        
        if selectedOption == "Light mode" {
            newOption = "light"
        } else {
            newOption = "dark"
        }
        
        
        defaults.set(newOption, forKey: "theme")
        
        updateUI()
        updateNavUI()
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
    }
    
    //Functions
    func setThemeSegmented() {
        let savedData = defaults.string(forKey: "theme")
        if savedData == "light" {
            themeSegmentedControll.selectedSegmentIndex = 0
        } else {
            themeSegmentedControll.selectedSegmentIndex = 1
        }
    }
}

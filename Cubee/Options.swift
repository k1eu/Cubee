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
    
    //View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        hideKeyboardWhenTappedAround()
    }
    
    //Actions
    @IBAction func nickChanged(_ sender: Any) {
        let newNick = nickTextfield.text
        defaults.set(newNick, forKey: "Nick")
    }
    
    @IBAction func avgControllValueChanged(_ sender: UISegmentedControl) {
        let selectedSegment = sender.selectedSegmentIndex
        let newOption = sender.titleForSegment(at: selectedSegment)
        
        defaults.set(newOption, forKey: "AVG")
    }
    
    @IBAction func themeControllValueChanged(_ sender: UISegmentedControl) {
        let selectedSegment = sender.selectedSegmentIndex
        let newOption = sender.titleForSegment(at: selectedSegment)
        
        defaults.set(newOption, forKey: "Theme")
    }
    
    
    //Functions
}

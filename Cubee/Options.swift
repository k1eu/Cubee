//
//  Options.swift
//  Cubee
//
//  Created by Tomasz Kielar on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class Options : UIViewController, UITextFieldDelegate {
    
    //Variables and Constants
    let defaults = UserDefaults.standard
    let colors = Colors()
    
    //Outlets
    @IBOutlet weak var nickTextfield: UITextField!
    @IBOutlet weak var avgSegmentedControll: UISegmentedControl!
    @IBOutlet weak var themeSegmentedControll: UISegmentedControl!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    //View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        hideKeyboardWhenTappedAround()
        nickTextfield.delegate = self
        setSubmitButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        setThemeSegmented()
        setAvgSegmented()
        updateBackButton()
        nickTextfield.text = ""
        setNicknameLabel()
        setVersionLabel()
    }
    override func viewWillDisappear(_ animated: Bool) {
        nicknameLabel.text = "Nickname"
    }
    
    //Actions
    @IBAction func nickChanged(_ sender: UITextField) {
        
    }
    
    @IBAction func avgControllValueChanged(_ sender: UISegmentedControl) {
        let selectedSegment = sender.selectedSegmentIndex
        let selectedOption = sender.titleForSegment(at: selectedSegment)
        var newOption = ""
        
        switch selectedOption {
        case "5 results":
            newOption = "5"
        case "10 results":
            newOption = "10"
        case "15 results":
            newOption = "15"
        case "20 results":
            newOption = "20"
        default:
            print("Error: You dont have other choices")
        }
        
        defaults.set(newOption, forKey: "count")
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
        updateBackButton()
        setVersionLabel()
    }
    
    func setNicknameLabel() {
        nicknameLabel.adjustsFontSizeToFitWidth = true
        nicknameLabel.minimumScaleFactor = 0.5
        nickTextfield.backgroundColor = colors.buttonBgLight
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        let newNick = nickTextfield.text
        if newNick == "" {
            print("moj nick to \(newNick)")
            nicknameLabel.text = "Can't be nothing!"
            nicknameLabel.textColor = .red
            }
        else {
            defaults.set(newNick, forKey: "nick")
            nickTextfield.text = ""
            print("moj nowy nick to \(newNick)")
            nicknameLabel.text = "Successfully changed nickname!"
            nicknameLabel.textColor = .green
        }
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        let newNick = nickTextfield.text
        if newNick == "" {
            print("moj nick to \(newNick)")
            nicknameLabel.text = "Can't be nothing!"
            nicknameLabel.textColor = .red
        }
        else {
            defaults.set(newNick, forKey: "nick")
            nickTextfield.text = ""
            print("moj nowy nick to \(newNick)")
            nicknameLabel.text = "Successfully changed nickname!"
            nicknameLabel.textColor = .green
        }
        
        return false
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
    
    func setSubmitButton() {
        submitButton.layer.cornerRadius = 10
    }
    
    func setAvgSegmented() {
        let savedData = defaults.string(forKey: "count")
        switch savedData {
        case "5":
            avgSegmentedControll.selectedSegmentIndex = 0
        case "10":
            avgSegmentedControll.selectedSegmentIndex = 1
        case "15":
            avgSegmentedControll.selectedSegmentIndex = 2
        case "20":
            avgSegmentedControll.selectedSegmentIndex = 3
        default:
            print("Error: You dont have other choices")
        }
    }
    
    func setVersionLabel() {
        let versionObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject?
        
        let versionString = versionObject as! String
        
        if versionString != "" {
            versionLabel.text = versionString
        } else {
            versionLabel.text = "Error"
        }
        
        if let theme = defaults.string(forKey: "theme") {
            if theme == "light" {
                versionLabel.textColor = .gray
            }
            else if theme == "dark" {
                versionLabel.textColor = .lightGray
            }
        }
    }
}

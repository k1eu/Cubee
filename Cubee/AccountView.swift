//
//  AccountView.swift
//  Cubee
//
//  Created by Tomasz Kielar on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class AccountView : UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var resultsButton: UIButton!
    @IBOutlet weak var pickImageButton: UIButton!
    
    let defaults = UserDefaults.standard
    var imagePicker = UIImagePickerController()
    var colors = Colors()
    
    override func viewDidLoad() {
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        
        updateBackButton()
        setNickname()
        setAvatar()
        tableView.reloadData()
        setAddAvatarButton()
        setResultsButton()
        print(defaults.stringArray(forKey: "times3x3"))
    }
    
    
    //actions
    @IBAction func pickImageAction(_ sender: Any) {
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                print("Button capture")
                
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = false
                
                present(imagePicker, animated: true, completion: nil)
            }
        }
        
    
    
    //functions
    func setNickname() {
        let actualNick = "Nickname"
        nickLabel.text = actualNick
        if let nickname = defaults.string(forKey: "nick"), nickname != "" {
            nickLabel.text = nickname
        }
        
    }
    func setTableView() {
        tableView.register(ResultsCell.self, forCellReuseIdentifier: "ResultId")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 10
    }
    
    func setAvatar() {
        
        if let imgURL = defaults.url(forKey: "imgurl") {
            if let imageData: NSData = NSData(contentsOf: imgURL) {
                accountImage.image = UIImage(data: imageData as Data)
                accountImage.layer.masksToBounds = true
                accountImage.layer.cornerRadius = 10
            }
            else {
                accountImage.image = UIImage(named:"account")
            }
        }
        else {
            accountImage.image = UIImage(named:"account")
        }
        

    }
    func setAddAvatarButton() {
        
        if let chosen = defaults.string(forKey: "theme") {
            if chosen == "light" {
                pickImageButton.backgroundColor = colors.navbarLight
                pickImageButton.layer.borderColor = colors.navbarDark.cgColor
                pickImageButton.layer.borderWidth = 2
                pickImageButton.layer.cornerRadius = pickImageButton.frame.width/2
                pickImageButton.titleLabel?.textAlignment = .center
                pickImageButton.contentVerticalAlignment = .center
            }
            else {
                pickImageButton.backgroundColor = colors.navbarLight
                pickImageButton.layer.borderColor = colors.navbarDark.cgColor
                pickImageButton.layer.borderWidth = 2
                pickImageButton.layer.cornerRadius = pickImageButton.frame.width/2
                pickImageButton.titleLabel?.textAlignment = .center
                pickImageButton.contentVerticalAlignment = .center
                pickImageButton.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    func setResultsButton() {
        resultsButton.layer.cornerRadius = 5
        resultsButton.contentVerticalAlignment = .top
    }
    
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print("weszlo")
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        print("czy to to ", image)
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
            defaults.set(imagePath, forKey: "imgurl")
        }
        
        
        if let imageData: NSData = NSData(contentsOf: imagePath) {
            accountImage.image = UIImage(data: imageData as Data)
        }
        else {
            accountImage.image = UIImage(named:defaults.string(forKey: "account")!)
        }

    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //tableview configuarion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let savedTimes = defaults.stringArray(forKey: "times3x3") else {return 1}
        if savedTimes.count < 4 {
            return savedTimes.count
        }
        else {
            return 4
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewHeight = tableView.frame.height
        return tableViewHeight/4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultId") as! ResultsCell
        if let storedResults = defaults.stringArray(forKey: "times3x3") {
            cell.timeLabel.text = storedResults[indexPath.row]
            return cell
        }
        else {
            return cell
        }
    }
}

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        updateBackButton()
        setNickname()
        setAvatar()
        setTableView()
        print(defaults.stringArray(forKey: "times"))
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
        let actualImage = defaults.string(forKey: "img")
        
        accountImage.image = UIImage(named: actualImage ?? "account")
    }
    
    /*func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        print("weszlo")
        accountImage.image = image
        print("siema ", image)
        defaults.set(image, forKey: "img")
    }*/
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print("weszlo")
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        print("czy to to ", image)
        accountImage.image = image
    }
    
    //tableview configuarion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let savedTimes = defaults.stringArray(forKey: "times3x3") else {return 1}
        return savedTimes.count
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

//
//  Cells.swift
//  Cubee
//
//  Created by Tomasz Kielar on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

struct SettingsCell {
    var labelText : String?
    var imgName : String?
}


class MenuCell : BaseCell {
    let defaults = UserDefaults.standard
    let colors = Colors()
    
    var setting: SettingsCell? {
        didSet {
            
            avatarView.removeConstraints(avatarView.constraints)
            
            if let mode = defaults.string(forKey: "theme"){
                if mode == "light" {
                    labelName.textColor = .black
                    cellBackground.backgroundColor = colors.navbarLight
                }
                else if mode == "dark" {
                    labelName.textColor = .white
                    cellBackground.backgroundColor = .darkGray
                }
                else {
                    print("prableeem")
                }
            }
            
            
            avatarView.isHidden = true
            labelName.isHidden = true
            if let label = setting?.labelText {
                labelName.text = label
                labelName.isHidden = false
                if setting?.imgName == nil {
                    setOnlyLabelConstraints()
                    //          setBackgroundConstraints()
                }
            }
            
            
            
            if let image = setting?.imgName {
                
                avatarView.image = UIImage(named: image)
                avatarView.isHidden = false
                cellBackground.alpha = 1
                if setting?.labelText == nil {
                    if image == "options" {
                        setOptionsConstraints()
                        cellBackground.alpha = 0
                        
                        if let mode = defaults.string(forKey: "theme"){
                            if mode == "light" {
                                let temporaryImg = avatarView.image?.imageWithColor(color1: .black)
                                avatarView.image = temporaryImg
                            }
                            else if mode == "dark" {
                                let temporaryImg = avatarView.image?.imageWithColor(color1: .white)
                                avatarView.image = temporaryImg
                            }
                        }
                        
                    }
                    else {
                        setOnlyImgConstraints()
                    }
                }
                else {
                    if image == "account" {
                        setAccountConstraints()
                        var savedImage = UIImage()
                        if let imgURL = defaults.url(forKey: "imgurl") {
                            if let imageData: NSData = NSData(contentsOf: imgURL) {
                                savedImage = UIImage(data: imageData as Data)!
                                avatarView.image = savedImage
                                avatarView.layer.masksToBounds = true
                                avatarView.contentMode = .scaleAspectFill
                                avatarView.layer.cornerRadius = 35
                                
                                
                            }
                        }
                    }
                    else {
                        setStandardConstraints()
                    }
                    
                }
                
            }
        }
    }
    
    let labelName : UILabel = {
        let label = UILabel()
        label.text = "Settings"
        return label
    }()
    
    var avatarView = UIImageView()
    
    let cellBackground = UIView()
    
    override func setUpViews() {
        super.setUpViews()
        cellBackground.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        insertSubview(cellBackground, at: 0)
        addSubview(labelName)
        addSubview(avatarView)
        labelName.adjustsFontSizeToFitWidth = true
        labelName.minimumScaleFactor = 0.1
        labelName.numberOfLines = 0
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.textAlignment = .center
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        cellBackground.translatesAutoresizingMaskIntoConstraints = false
        setBackgroundConstraints()
        
    }
    
    func setBackgroundConstraints() {
        cellBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:20).isActive = true
        cellBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        cellBackground.topAnchor.constraint(equalTo: self.topAnchor, constant:  20).isActive = true
        cellBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -20).isActive = true
        cellBackground.layer.cornerRadius = 10
    }
    func setOptionsBackgroundConstraints() {
        cellBackground.removeFromSuperview()
    }
    
    
    func setStandardConstraints() {
        avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor).isActive = true
        avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        avatarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -65).isActive = true
        avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelName.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 15).isActive = true
    }
    
    func setAccountConstraints() {
        avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor).isActive = true
        avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        avatarView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        
        labelName.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 5).isActive = true
        labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        labelName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        labelName.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -25).isActive = true
    }
    func setOptionsConstraints() {
        labelName.isHidden = true
        avatarView.isHidden = false
        avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 55).isActive = true
        avatarView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -55).isActive = true
        avatarView.heightAnchor.constraint(equalTo:avatarView.widthAnchor).isActive = true
    }
    
    func setOnlyImgConstraints() {
        labelName.isHidden = true
        avatarView.isHidden = false
        avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatarView.heightAnchor.constraint(equalTo:avatarView.widthAnchor).isActive = true
        avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        avatarView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
    }
    func setOnlyLabelConstraints() {
        labelName.isHidden = false
        avatarView.isHidden = true
        
        labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}

class BaseCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    func setUpViews() {
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




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
    
    
    
    var setting: SettingsCell? {
        didSet {
            
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
                    }
                    else {
                      setOnlyImgConstraints()
             //           setBackgroundConstraints()
                    }
                }
                else {
                    setStandardConstraints()
           //         setBackgroundConstraints()
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
        labelName.translatesAutoresizingMaskIntoConstraints = false
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
        avatarView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 85).isActive = true
        avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatarView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant:-20).isActive = true
        
        labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelName.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 15).isActive = true
    }
    func setOptionsConstraints() {
        labelName.isHidden = true
        avatarView.isHidden = false
        avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatarView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setOnlyImgConstraints() {
        labelName.isHidden = true
        avatarView.isHidden = false
        avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatarView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 85).isActive = true
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

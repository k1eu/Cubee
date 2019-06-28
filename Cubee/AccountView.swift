//
//  AccountView.swift
//  Cubee
//
//  Created by Tomasz Kielar on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class AccountView : UIViewController {
    
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var resultsButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        setNickname()
        setAvatar()
    }
    func setNickname() {
        let actualNick = "Nickname"
        nickLabel.text = actualNick
        if let nickname = defaults.string(forKey: "nick"), nickname != "" {
            nickLabel.text = nickname
        }
        
        
        
        
    }
    func setAvatar() {
        let actualImage = defaults.string(forKey: "img")
        
        accountImage.image = UIImage(named: actualImage ?? "account")
    }
}

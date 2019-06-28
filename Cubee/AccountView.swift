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
    /Users/k1eu/Programowanie/Xcode Saves/Cubee/Cubee/AccountView.swift
    func setNickname() {
        let actualNick = defaults.string(forKey: "nick")
        
        nickLabel.text = actualNick ?? "Nickname"
        
        
    }
    func setAvatar() {
        let actualImage = defaults.string(forKey: "img")
        
        accountImage.image = UIImage(named: actualImage ?? "account")
    }
}

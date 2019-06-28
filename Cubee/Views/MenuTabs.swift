//
//  MenuTabs.swift
//  Cubee
//
//  Created by Tomasz Kielar on 28/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class MenuOptions {
    var nickname : String = "Nickname"
    
    
    
    func setSettingsTabs() -> [SettingsCell] {
        if let setNick = UserDefaults.standard.string(forKey: "nick"), setNick != "" {
            nickname = setNick
        }
        let settings : [SettingsCell] = [
            SettingsCell(labelText: nickname, imgName: "account"),
            SettingsCell(labelText: "Kostka1", imgName: nil),
            SettingsCell(labelText: nil, imgName: "account"),
            SettingsCell(labelText: nil, imgName: "options")
        ]
        return settings
    }
    
}

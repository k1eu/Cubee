//
//  TimesView.swift
//  Cubee
//
//  Created by Tomasz Kielar on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class TimesView : UIViewController {
    
    @IBOutlet weak var bestTimeLabel: UILabel!
    @IBOutlet weak var lastTimeLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        setBestTime()
        setLastTime()
    }
    
    func setBestTime() {
        let savedTimes = defaults.stringArray(forKey: "times") ?? nil
        
        var bestTime = savedTimes?.first! ?? "---"
        
        if bestTime != "---" {
            for anotherTime in savedTimes! {
                bestTime = bestTime < anotherTime ? bestTime : anotherTime
            }
        }
        
        bestTimeLabel.text = "Best time\n" + bestTime
    }
    
    func setLastTime() {
        let savedTimes = defaults.stringArray(forKey: "times") ?? nil
        
        lastTimeLabel.text = "Last time\n" + (savedTimes?.last! ?? "---")
    }
}

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
        setAvg()
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
    
    func setAvg() {
        let savedTimes = defaults.stringArray(forKey: "times") ?? nil
        
        var summaryOfTimes = 0
        var avgText = "AVG of last 5\n---"
        if savedTimes != nil && savedTimes!.count >= 5 {
            for time in savedTimes!.suffix(5) {
                //wyciaganie intow ze stringa
                let minutes = Int(String(time.prefix(2)))
                
                let minutesAndSeconds = String(time.prefix(5))
                let seconds = Int(String(minutesAndSeconds.suffix(2)))
                
                let hundreds = Int(String(time.suffix(2)))
                
                //zamienianie na setne
                let minutesToHundreds = minutes! * 60 * 100
                let secondsToHundreds = seconds! * 100
                
                //dodawanie wszystkiego do summaryOfTimes
                summaryOfTimes += minutesToHundreds + secondsToHundreds + hundreds!
            }
            
            //zamienianie na czas min:sec:set
            summaryOfTimes /= 5
            
            let avgMinutes = summaryOfTimes/6000
            let sumWithoutMinutes = summaryOfTimes%6000
            
            let avgSeconds = sumWithoutMinutes/100
            let avgHundreds = sumWithoutMinutes%100
            
            //zapisywanie czasu jako string
            avgText = "AVG of last 5\n" + String(format: "%02d:%02d.%02d", avgMinutes, avgSeconds, avgHundreds)
        }
        
        avgLabel.text = avgText
    }
}

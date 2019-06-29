//
//  TimesView.swift
//  Cubee
//
//  Created by Tomasz Kielar on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class TimesView : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cubeChangeSegmented: UISegmentedControl!
    
    @IBOutlet weak var bestTimeLabel: UILabel!
    @IBOutlet weak var lastTimeLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    
    let defaults = UserDefaults.standard
    var chosenCube = "3x3"
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        updateBackButton()
        setTableView()
        setBestTime()
        setLastTime()
        setAvg()
    }
    
    //Configure Table View Results
    
    func setTableView() {
    tableView.register(ResultsCell.self, forCellReuseIdentifier: "detailedCell")
    tableView.delegate = self
    tableView.dataSource = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.layer.cornerRadius = 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var howManyRows = 1
        if chosenCube == "3x3" {
            if let threeByThree = defaults.stringArray(forKey: "times3x3") {
                howManyRows = threeByThree.count
            }
        }
        else if chosenCube == "2x2" {
            if let twoByTwo = defaults.stringArray(forKey: "times2x2") {
                howManyRows = twoByTwo.count
            }
        }
        else if chosenCube == "piraminx" {
            if let piraminx = defaults.stringArray(forKey: "timesPiraminx") {
                howManyRows = piraminx.count
            }
        }
        
        let count = defaults.string(forKey: "count")
        switch count {
        case "5":
            howManyRows = howManyRows > 5 ? 5 : howManyRows
        case "10":
            howManyRows = howManyRows > 10 ? 10 : howManyRows
        case "15":
            howManyRows = howManyRows > 15 ? 15 : howManyRows
        case "20":
            howManyRows = howManyRows > 20 ? 20 : howManyRows
        default:
            print("Error: You dont have other choices")
        }
        return howManyRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailedCell") as! ResultsCell
        
        if chosenCube == "3x3" {
            if let threeByThree = defaults.stringArray(forKey: "times3x3") {
                cell.timeLabel.text = threeByThree[indexPath.row]
            }
        }
        else if chosenCube == "2x2" {
            if let twoByTwo = defaults.stringArray(forKey: "times2x2") {
                cell.timeLabel.text = twoByTwo[indexPath.row]
            }
            else {
                cell.timeLabel.text = "You have no times in 2x2"
            }
        }
        else if chosenCube == "piraminx" {
            if let piraminx = defaults.stringArray(forKey: "timesPiraminx") {
                cell.timeLabel.text = piraminx[indexPath.row]
            }
            else {
                cell.timeLabel.text = "You have no times in piraminx"
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/8
    }
    
    @IBAction func changingCubeControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            chosenCube = "3x3"
        case 1:
            chosenCube = "2x2"
        case 2:
            chosenCube = "piraminx"
        default:
            print("we've got a problem in segmented control")
        }
        tableView.reloadData()
        setBestTime()
        setLastTime()
        setAvg()
    }
    
    //Functions
    
    
    func setBestTime() {
        let key = chosenCube == "piraminx" ? "timesPiraminx" : "times" + chosenCube
        let savedTimes = defaults.stringArray(forKey: key) ?? nil
        
        var bestTime = savedTimes?.first! ?? "---"
        
        if bestTime != "---" {
            for anotherTime in savedTimes! {
                bestTime = bestTime < anotherTime ? bestTime : anotherTime
            }
        }
        
        bestTimeLabel.text = "Best time\n" + bestTime
    }
    
    func setLastTime() {
        let key = chosenCube == "piraminx" ? "timesPiraminx" : "times"+chosenCube
        let savedTimes = defaults.stringArray(forKey: key) ?? nil
        
        lastTimeLabel.text = "Last time\n" + (savedTimes?.first! ?? "---")
    }
    
    func setAvg() {
        let key = chosenCube == "piraminx" ? "timesPiraminx" : "times"+chosenCube
        let savedTimes = defaults.stringArray(forKey: key) ?? nil
        
        var summaryOfTimes = 0
        var avgText = "AVG of last 5\n---"
        if savedTimes != nil && savedTimes!.count >= 5 {
            for time in savedTimes!.prefix(5) {
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

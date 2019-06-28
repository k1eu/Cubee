//
//  ViewController.swift
//  Cubee
//
//  Created by Tomasz Kielar on 05/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var sortingAlgorithmLabel: UILabel!
    @IBOutlet weak var stopButtonOutlet: UIButton!
    
    // Variables and Constants
    let stopwatch = Stopwatch()
    let sortingInstance = Sorting()
    lazy var menu : Menu = {
        let leftSideMenu = Menu()
        leftSideMenu.mainController = self
        return leftSideMenu
    }()
    var savedTimes3x3 = [String]()
    var savedTimes2x2 = [String]()
    var savedTimesPiraminx = [String]()
    var timesCouter3x3 = 0
    var timesCouter2x2 = 0
    var timesCouterPiraminx = 0
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortingAlgorithmLabel.text = makeSortingAlgorithm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        updateNavUI()
    }

    //Actions
    @IBAction func startButtonAction(_ sender:
        UIButton) {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {
            timer in
            self.updateLabel(timer)
            }
        )
        stopwatch.start()
    }
    @IBAction func stopButtonAction(_ sender: UIButton) {
        let result = timerLabel.text
        stopwatch.stop()
        timerLabel.text = result
        
        saveTime(time: result!)
        
        sortingAlgorithmLabel.text = makeSortingAlgorithm()
    }
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        
        if !menu.isMenuOpen {
            menu.darkenBackground(view:view)
            menu.showMenu(view:view)
        }
        else {
            let startingMenuPosition = CGRect(x: 0, y: 0, width: 0, height: view.frame.height)
            UIView.animate(withDuration: 0.5, animations: {
                self.menu.blackView.alpha = 0
                self.menu.menuCollectionView.frame = startingMenuPosition
            })
            menu.isMenuOpen = false
        }
    }
    
    //functions
    func updateLabel(_ timer : Timer) {
        if stopwatch.isRunning {
        let minutes = Int(stopwatch.elapsedTime / 60)
        let seconds = Int(stopwatch.elapsedTime.truncatingRemainder(dividingBy: 60))
        let tenthsOfSecond = Int((stopwatch.elapsedTime * 100).truncatingRemainder(dividingBy: 100))

        timerLabel.text = String(format: "%02d:%02d.%02d",
               minutes, seconds, tenthsOfSecond)
        }
        else {
           timer.invalidate()
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startingMenuPosition = CGRect(x: 0, y: 0, width: 0, height: view.frame.height)
        if let touch = touches.first, touch.view == menu.blackView {
            UIView.animate(withDuration: 0.5, animations: {
                self.menu.blackView.alpha = 0
                self.menu.menuCollectionView.frame = startingMenuPosition
            })
            menu.isMenuOpen = false
        }
    }
    
    func saveTime(time: String) {
        let cubeType = defaults.string(forKey: "cubeType")
        if let twoByTwo = defaults.stringArray(forKey: "times2x2") {
            timesCouter2x2 = twoByTwo.count
            savedTimes2x2 = twoByTwo
        }
        if let threeByThree = defaults.stringArray(forKey: "times3x3") {
            timesCouter3x3 = threeByThree.count
            savedTimes3x3 = threeByThree
        }
        if let piraminx = defaults.stringArray(forKey: "timesPiraminx") {
            timesCouterPiraminx = piraminx.count
            savedTimesPiraminx = piraminx
        }
        
        switch cubeType! {
        case "3x3":
            if timesCouter3x3 >= 0 && timesCouter3x3 < 20  {
                savedTimes3x3.insert(time, at: 0)
                print("added new time: \(time)")
            } else if timesCouter3x3 >= 20 {
                savedTimes3x3.removeLast()
                savedTimes3x3.insert(time, at: 0)
                print(savedTimes3x3)
                print("deletedlast added new")
            } else {
                print("Error: couldnt save time")
            }
            
            defaults.set(savedTimes3x3, forKey: "times3x3")
        case "2x2":
            if timesCouter2x2 >= 0 && timesCouter2x2 < 20  {
                savedTimes2x2.insert(time, at: 0)
                print("added new time: \(time)")
            } else if timesCouter2x2 >= 20 {
                savedTimes2x2.removeFirst()
                savedTimes2x2.insert(time, at: 0)
                print(savedTimes2x2)
                print("deletedlast added new")
            } else {
                print("Error: couldnt save time")
            }
            
            defaults.set(savedTimes2x2, forKey: "times2x2")
        case "Piraminx":
            if timesCouterPiraminx >= 0 && timesCouterPiraminx < 20  {
                savedTimesPiraminx.insert(time, at: 0)
                print("added new time: \(time)")
            } else if timesCouterPiraminx >= 20 {
                savedTimesPiraminx.removeFirst()
                savedTimesPiraminx.insert(time, at: 0)
                print(savedTimesPiraminx)
                print("deletedlast added new")
            } else {
                print("Error: couldnt save time")
            }
            
            defaults.set(savedTimesPiraminx, forKey: "timesPiraminx")
        default:
            print("Sth went wrong")
        }
        
        
    }
}


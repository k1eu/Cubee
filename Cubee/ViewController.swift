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
    @IBOutlet weak var refreshAlgorithmButton: UIButton!
    @IBOutlet weak var refreshLabel: UILabel!
    @IBOutlet weak var clickAnywhere: UILabel!
    @IBOutlet weak var cubeType: UIImageView!
    
    // Variables and Constants
    let menuBtn = UIButton(type: .custom)
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
    var isRunning : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sortingAlgorithmLabel.text = makeSortingAlgorithm()
        updateUI()
        updateNavUI()
        updateCube()
        setStartButton()
        setMenuButton()
        updateRefreshButton()
        setRefreshLabel()
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
        
        startOptions()
    }

    @IBAction func refreshAlgorithm(_ sender: Any) {
        sortingAlgorithmLabel.text = makeSortingAlgorithm()
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
    func updateRefreshButton() {
        refreshAlgorithmButton.backgroundColor = .clear
        if let chosen = defaults.string(forKey: "theme") {
            if chosen == "light" {
                let xd = refreshAlgorithmButton.imageView?.image?.imageWithColor(color1: .black)
                refreshAlgorithmButton.setImage(xd, for: .normal)
            }
            else {
                let xd = refreshAlgorithmButton.imageView?.image?.imageWithColor(color1: .white)
                refreshAlgorithmButton.setImage(xd, for: .normal)
            }
        }
    }

    func setMenuButton() {
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        menuBtn.setImage(UIImage(named: "menu"), for: .normal)
        setMenuMode()
        menuBtn.addTarget(self, action: #selector(clickedMenu), for: UIControl.Event.touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        self.navigationItem.leftBarButtonItem = menuBarItem
        self.navigationItem.leftBarButtonItem?.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.navigationItem.leftBarButtonItem?.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setMenuMode() {
        let image = menuBtn.image(for: .normal)
        if let theme = defaults.string(forKey: "theme") {
            switch theme {
            case "light" :
                menuBtn.setImage(image, for: .normal)
            case "dark" :
                menuBtn.setImage(image!.imageWithColor(color1: .white), for: .normal)
            default:
                print("no default")
            }
        }
    }
    
    @objc func clickedMenu() {
        if !menu.isMenuOpen {
            menuBtn.setImage(UIImage(named: "close"), for: .normal)
            setMenuMode()
            let menuBarIteam = UIBarButtonItem(customView: menuBtn)
            self.navigationItem.leftBarButtonItem = menuBarIteam
            menu.darkenBackground(view:view)
            menu.showMenu(view:view)
            menu.isMenuOpen = true
        }
        else {
            menuBtn.setImage(UIImage(named: "menu"), for: .normal)
            setMenuMode()
            let menuBarIteam = UIBarButtonItem(customView: menuBtn)
            let startingMenuPosition = CGRect(x: 0, y: 0, width: 0, height: view.frame.height)
            UIView.animate(withDuration: 0.5, animations: {
                self.menu.blackView.alpha = 0
                self.menu.menuCollectionView.frame = startingMenuPosition
            })
            self.navigationItem.leftBarButtonItem = menuBarIteam
            menu.isMenuOpen = false
        }
    }
    
    func updateCube() {
        if let type = defaults.string(forKey: "cubeType"){
            if type == "2x2" {
                cubeType.image = UIImage(named: "cube2")
            }
            else if type == "3x3" {
                cubeType.image = UIImage(named: "cube1")
            }
            else if type == "Piraminx"{
            cubeType.image = UIImage(named:"cube3")
            }
        }
    }
        
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startingMenuPosition = CGRect(x: 0, y: 0, width: 0, height: view.frame.height)
        if stopwatch.isRunning {
            if let touch = touches.first {
                let result = timerLabel.text
                stopwatch.stop()
                timerLabel.text = result
                
                saveTime(time: result!)
                
                endOptions()
                setStartButton()
            }
        }
        if let touch = touches.first, touch.view == menu.blackView {
            UIView.animate(withDuration: 0.5, animations: {
                self.menu.blackView.alpha = 0
                self.menu.menuCollectionView.frame = startingMenuPosition
            })
            menu.isMenuOpen = false
            menuBtn.setImage(UIImage(named: "menu"), for: .normal)
            setMenuMode()
            let menuBarIteam = UIBarButtonItem(customView: menuBtn)
            self.navigationItem.leftBarButtonItem = menuBarIteam
        }
        if let touch = touches.first, touch.view == self.navigationItem.leftBarButtonItem?.customView {
            print("shit")
        }
    }
    
    func setStartButton() {
        startButtonOutlet.layer.cornerRadius = 10
        startButtonOutlet.alpha = 0.8
        startButtonOutlet.titleLabel?.numberOfLines = 1
        startButtonOutlet.translatesAutoresizingMaskIntoConstraints = false
        startButtonOutlet.titleLabel?.frame = startButtonOutlet.frame
        if timerLabel.text != "00:00:00" {
            startButtonOutlet.setTitle("Restart", for: .normal)
        }
        else {
            startButtonOutlet.setTitle("Start", for: .normal)
        }
    }
    
    func setRefreshLabel() {
        if let theme = defaults.string(forKey: "theme") {
            if theme == "light" {
                refreshLabel.textColor = .gray
            }
            else if theme == "dark" {
                refreshLabel.textColor = .lightGray
            }
        }
    }
    
    func startOptions() {
        refreshAlgorithmButton.isHidden = true
        refreshLabel.isHidden = true
        sortingAlgorithmLabel.isHidden = true
        clickAnywhere.isHidden = false
        startButtonOutlet.isHidden = true
        
    }
    func endOptions() {
        refreshLabel.isHidden = false
        refreshAlgorithmButton.isHidden = false
        sortingAlgorithmLabel.isHidden = false
        clickAnywhere.isHidden = true
        startButtonOutlet.isHidden = false
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


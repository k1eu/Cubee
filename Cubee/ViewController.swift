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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let algorithm = sortingInstance.threeByThree()
        sortingAlgorithmLabel.text = algorithm
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
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
}


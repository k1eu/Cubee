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

    @IBOutlet weak var stopButtonOutlet: UIButton!
    
    // Variables and Constants
    let stopwatch = Stopwatch()

    @IBOutlet weak var sortingAlgorithmLabel: UILabel!
    
    // Variables and Constants
    let sortingInstance = Sorting()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let algorithm = sortingInstance.threeByThree()
        sortingAlgorithmLabel.text = algorithm
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
        darkenBackground()
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
    func darkenBackground () {
        if let window = UIApplication.shared.keyWindow {
        let blackView = UIView()
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            //blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
    
        window.addSubview(blackView)
        blackView.frame = window.frame
        blackView.alpha = 0
        
            UIView.animate(withDuration: 0.5, animations: {
                blackView.alpha = 1
            })
        }
    }
}


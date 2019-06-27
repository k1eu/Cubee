//
//  ViewController.swift
//  Cubee
//
//  Created by Tomasz Kielar on 05/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButtonOutlet: UIButton!
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
    @IBAction func startButtonAction(_ sender: UIButton) {
    }
    
    //functions
}


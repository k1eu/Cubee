//
//  Timer.swift
//  Cubee
//
//  Created by Tomasz Kielar on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class Stopwatch {
    var isRunning : Bool = false
    
    private var startTime: Date?
    
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    func start() {
        startTime = Date()
        isRunning = true
    }
    
    func stop() {
        startTime = nil
        isRunning = false
    }
}

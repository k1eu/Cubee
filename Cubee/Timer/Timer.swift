//
//  Timer.swift
//  Cubee
//
//  Created by Tomasz Kielar on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class Timer {
    var isCounting : Bool = false
    
    private var startTime: Date?
    
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var isRunning: Bool {
        isCounting = !isCounting
        return isCounting
    }
    
    func start() {
        startTime = Date()
    }
    
    func stop() {
        startTime = nil
    }
}

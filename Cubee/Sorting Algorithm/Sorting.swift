//
//  Sorting.swift
//  Cubee
//
//  Created by Tomasz Kielar on 27/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

struct Sorting {
    let letters3x3: [String] = ["U", "U'", "2U", "D", "D'", "2D", "R", "R'", "2R", "L", "L'", "2L", "F", "F'", "2F", "B","B'", "2B", "M","M'", "2M"]
    
    func threeByThree() -> String {
        
        var algorithm: String = ""
        
        for _ in 0...19 {
            let symbolIndex = Int.random(in: 0...20)
            algorithm += self.letters3x3[symbolIndex]
            algorithm += " "
        }
        
        return algorithm
    }
}

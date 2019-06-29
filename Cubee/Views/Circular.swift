//
//  Circular.swift
//  Cubee
//
//  Created by Tomasz Kielar on 29/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func asCircle(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
    
}

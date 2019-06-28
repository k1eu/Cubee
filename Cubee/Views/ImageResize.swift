//
//  ImageResize.swift
//  Cubee
//
//  Created by Tomasz Kielar on 28/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

extension UIImage{
    func resizeImage(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}


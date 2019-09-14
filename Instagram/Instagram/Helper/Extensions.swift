//
//  Extensions.swift
//  Instagram
//
//  Created by 宋超 on 2019/8/29.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var mainBlue = UIColor.rgb(red: 17, green: 154, blue: 237)
    
    static func rgb (red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


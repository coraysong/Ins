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


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,left: NSLayoutXAxisAnchor?, bottom:NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width:CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension UINavigationController {
    
    override open var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
//    
//    override open var childForStatusBarStyle: UIViewController? {
//        return self.topViewController
//    }
    
}


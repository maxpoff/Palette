//
//  UIViewExtension.swift
//  PaletteiOS29
//
//  Created by Maxwell Poffenbarger on 2/11/20.
//  Copyright © 2020 Darin Armstrong. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, topPadding: CGFloat, bottomPadding: CGFloat, leadingPadding: CGFloat, trailingPadding: CGFloat, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomPadding).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -trailingPadding).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}//End of extension

struct spacingConstants {
    
    static let verticalObjectBuffer: CGFloat = 8
    static let outerHorizontalPadding: CGFloat = 24
    static let outerVerticalPadding: CGFloat = 16
    static let oneLineElementHeight: CGFloat = 24
    static let twoLineElementHeight: CGFloat = 32
}//End of struct

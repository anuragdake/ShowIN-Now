//
//  AppUtils.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import UIKit

class AppUtils{
    
    public func hexStringToUIColor(hex: String) -> UIColor {
        var colorString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (colorString.hasPrefix("#")) {
            colorString = String(colorString.suffix(from: colorString.index(colorString.startIndex, offsetBy: 1)))
            
        }
        if ((colorString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue: UInt32 = 0
        Scanner(string: colorString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

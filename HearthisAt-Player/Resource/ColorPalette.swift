//
//  ColorPalette.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import SwiftHEXColors

extension UIColor {
 
    // MARK: Backgrounds
    
    static var hta_backgroundGradient: [UIColor] {
        return [UIColor(hexString: "#FF512F")!, UIColor(hexString: "#DD2476")!]
    }
    
    // MARK: Text
    
    static var hta_textPrimary: UIColor {
        return UIColor.white
    }
    
    static var hta_textSecondary: UIColor {
        return UIColor(hexString: "#DCDCDC")!
    }
}

//
//  String+Localization.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

extension String {
    
    func localized(args: CVarArg...) -> String {
        let localized = NSLocalizedString(self, comment: "")
        return withVaList(args) { (vaListPtr) -> String in
            return NSString(format: localized, arguments: vaListPtr) as String
        }
    }
}

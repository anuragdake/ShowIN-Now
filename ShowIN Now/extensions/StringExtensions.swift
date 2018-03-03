//
//  StringExtensions.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import Foundation

extension String {
    /**
     Used to get localized string.
     */
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

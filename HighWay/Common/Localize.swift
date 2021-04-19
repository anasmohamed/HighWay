//
//  Localize.swift
//  HighWay
//
//  Created by Anas Mohamed on 19/04/2021.
//

import Foundation
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

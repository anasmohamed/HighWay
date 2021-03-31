//
//  PlaceholderCenterText.swift
//  HighWay
//
//  Created by no one on 31/03/2021.
//

import Foundation
import UIKit
extension String {
    func toAttributed(alignment: NSTextAlignment) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return toAttributed(attributes: [.paragraphStyle: paragraphStyle])
    }

    func toAttributed(attributes: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
}

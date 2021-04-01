//
//  UIResponder + KeyboardExtension.swift
//  HighWay
//
//  Created by no one on 01/04/2021.
//

import Foundation
import UIKit

extension UIResponder {

    static weak var responder: UIResponder?

    static func currentFirst() -> UIResponder? {
        responder = nil
        UIApplication.shared.sendAction(#selector(trap), to: nil, from: nil, for: nil)
        return responder
    }

    @objc private func trap() {
        UIResponder.responder = self
    }
}

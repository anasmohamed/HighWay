//
//  ForgetPassowordProtocol.swift
//  HighWay
//
//  Created by no one on 02/04/2021.
//

import Foundation
protocol ForgetPasswordProtocol:class {
    func emailSentSuccessfuly(message:String)
    func showError(errorMessage:String)

}

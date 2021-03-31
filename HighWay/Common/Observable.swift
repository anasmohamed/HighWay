//
//  Observable.swift
//  HighWay
//
//  Created by no one on 31/03/2021.
//

import Foundation
class Observable<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}

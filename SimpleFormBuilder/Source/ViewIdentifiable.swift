//
//  ViewIdentifiable.swift
//  SimpleFormBuilder
//
//  Created by Nutan Niraula on 4/14/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import UIKit

protocol ViewIdentifiable: class {
    static var defaultReuseIdentifier: String { get }
}

extension ViewIdentifiable where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

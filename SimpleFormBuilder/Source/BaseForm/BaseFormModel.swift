//
//  BaseFormModel.swift
//  Hopper
//
//  Created by Nutan Niraula on 2/7/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation

struct BaseFormModel {
    
    var tag = 0
    var text = ""
    var placeholder = ""
    var isEnabled = true
    var hasTitleLabel = false
    var textType: TextType = .normal
    
    init(placeholder: String) {
        self.placeholder = placeholder
    }
    
    init(text: String, placeholder: String, textType: TextType, isEnabled: Bool, hasTitleLabel: Bool, rowIndex: Int) {
        self.text = text
        self.textType = textType
        self.placeholder = placeholder
        self.isEnabled = isEnabled
        self.hasTitleLabel = hasTitleLabel
        self.tag = rowIndex
    }
    
    init(text: String, placeholder: String, textType: TextType, rowIndex: Int) {
        self.text = text
        self.textType = textType
        self.placeholder = placeholder
        self.tag = rowIndex
    }
    
    init(placeholder: String, textType: TextType, rowIndex: Int) {
        self.textType = textType
        self.placeholder = placeholder
        self.tag = rowIndex
    }
    
}

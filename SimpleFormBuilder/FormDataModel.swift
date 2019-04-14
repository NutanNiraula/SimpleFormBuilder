//
//  FormDataModel.swift
//  SimpleFormBuilder
//
//  Created by Nutan Niraula on 4/14/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation

enum ProfileInformationType: Int {
    
    case fullName = 0, email, address, city, state, zip, phone
    
    var placeHolder: String {
        switch self {
        case .fullName: return "Full Name"
        case .email : return "Email"
        case .address: return "Address"
        case .city: return "City"
        case .state: return "State"
        case .zip: return "Zip"
        case .phone: return "Phone Number"
        }
    }
    
    var textType: TextType {
        switch self {
        case .fullName: return .name
        case .email: return .email
        case .address: return .address(type: AddressType.streetAddress)
        case .city: return .address(type: AddressType.city)
        case .state: return .picker(type: .picker(data: USStates.states))
        case .zip: return .address(type: AddressType.postalCode)
        case .phone: return .number(type: .contactNumber(type: .phoneNumber))
        }
    }
    
    var text: String {
        switch self {
        case .fullName: return ""
        case .email: return "testEmail@gmail.com"
        case .address: return ""
        case .city: return ""
        case .state: return ""
        case .zip: return ""
        case .phone: return ""
        }
    }
    
    var isEnabled: Bool {
        switch self {
        case .email: return false
        default: return true
        }
    }
    
    var model: BaseFormModel {
        return BaseFormModel(text: self.text, placeholder: self.placeHolder, textType: self.textType, isEnabled: self.isEnabled, hasTitleLabel: true, rowIndex: self.rawValue)
    }
    
}

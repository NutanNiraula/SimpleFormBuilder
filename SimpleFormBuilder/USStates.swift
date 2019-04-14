//
//  USStates.swift
//  SimpleFormBuilder
//
//  Created by Nutan Niraula on 4/14/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation

struct StateData: Decodable {
    var id: Int
    var abbreviation: String
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id, abbreviation, name
    }
}

struct USStates: Decodable {
    
    var states: [StateData]!
    
    private enum CodingKeys: String, CodingKey {
        case states
    }
    
    static func getState(fromId id: Int) -> String {
        let object = ObjectCreater<USStates>.createObject(fromJSONFile: "USStates")
        return object.states.filter({ $0.id == id }).first!.name
    }
    
    static var states: [String] {
        let object = ObjectCreater<USStates>.createObject(fromJSONFile: "USStates")
        return object.states.map({ $0.name })
    }
    
    static func getStateId(ofState state: String) -> Int? {
        let object = ObjectCreater<USStates>.createObject(fromJSONFile: "USStates")
        return (object.states.filter({ $0.name == state }).first?.id)
    }
    
}

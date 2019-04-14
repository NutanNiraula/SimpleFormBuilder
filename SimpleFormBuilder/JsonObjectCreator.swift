//
//  JsonObjectCreator.swift
//  SimpleFormBuilder
//
//  Created by Nutan Niraula on 4/14/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation

class ObjectCreater<OutputObject:Decodable>{
    static func createObject(fromJSONFile fileName:String) -> OutputObject {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            fatalError("couldnt find path")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        let decodedData = try! JSONDecoder().decode(OutputObject.self, from: data)
        return decodedData
    }
}

//
//  Category.swift
//  ArtiumFinal
//
//  Created by Chinmay Khot on 30/05/22.
//

import Foundation

struct Categories: Decodable {
    
    let values: [String]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let values = try container.decode([String].self)
        self.values = values
    }
}

struct Categories1: Decodable {
    
    let values: [String]
    
}

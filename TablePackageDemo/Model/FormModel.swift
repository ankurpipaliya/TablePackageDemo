//
//  FormModel.swift
//  TablePackageDemo
//
//  Created by AnkurPipaliya on 22/08/23.
//

import Foundation

enum SectionType {
    case radio
    case checkbox
}

class FormModel: Codable {
    var id: String
    var name: [String]
    var specifications: [Specification]
        
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, specifications
    }
}

class Specification: Codable {
    var uniqueId: Int
    var name: [String]
    var type: Int
    var list: [List]

    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
        case name, type, list
    }
}

class List: Codable {
    var uniqueId: Int
    var name: [String]
    var price: Double
    var isDefaultSelected: Bool
    var quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
        case name, price
        case isDefaultSelected = "is_default_selected"
        case quantity = "quanity"
    }
}

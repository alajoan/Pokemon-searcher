//
//  Pokedata.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 08/05/21.
//

import Foundation

struct Pokedata: Codable, Hashable{
    
    var abilities: [String]
    var detailPageURL: String
    var weight: Float
    var weakness: [String]
    var number: String
    var height: Float
    var name: String
    var thumbnailImage: String
    var id: Int
    var type: [String]
    
    enum CodingKeys: String, CodingKey {
        case abilities = "abilities"
        case detailPageURL = "detailPageURL"
        case weight = "weight"
        case weakness = "weakness"
        case number = "number"
        case height = "height"
        case name = "name"
        case thumbnailImage = "thumbnailImage"
        case id = "id"
        case type = "type"
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(number)
    }
}


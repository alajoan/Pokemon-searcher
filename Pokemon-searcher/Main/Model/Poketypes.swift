//
//  Poketypes.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 08/05/21.
//

import Foundation

struct PoketypesRoot: Codable {
    var results: [PoketypesResult]
}

struct PoketypesResult: Codable {
    var thumbnailImage: String
    var name: String?
}



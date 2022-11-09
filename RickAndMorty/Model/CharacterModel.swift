//
//  Character.swift
//  RickAndMorty
//
//  Created by Kazakov Danil on 09.11.2022.
//

import Foundation

struct Character: Codable {
    let results : [results]
}

struct results: Codable {
    let name : String
    let species: String
    let gender: String
    let image: String
    let status: String
    let location: Location
}

struct Location: Codable {
    let name: String
}

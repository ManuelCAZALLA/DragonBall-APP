//
//  AllHeroes.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 25/9/23.
//

import Foundation

struct Heroe: Decodable {
    let id: String
    let name: String
    let description: String?
    let favorite: Bool
    let photo: String
}

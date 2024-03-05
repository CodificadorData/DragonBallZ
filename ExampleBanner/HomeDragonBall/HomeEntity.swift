//
//  HomeEntity.swift
//  ExampleBanner
//
//  Created by Christian Morante on 18/02/24.
//

import Foundation

struct DragonBallEntity: Decodable {
    let items: [Item]
    let meta: Meta
    let links: Links
}

struct Item: Decodable {
    let id: Int
    let name: String
    let ki: String
    let maxKi: String
    let race: String
    let gender: String
    let description: String
    let image: String
    let affiliation: String
}

struct Links: Decodable {
    let next: String
}

struct Meta: Decodable {
    
}

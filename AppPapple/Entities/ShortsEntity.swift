//
//  ShortsEntity.swift
//  AppPapple
//
//  Created by Christian Morante on 2/08/25.
//

struct ShortsEntity: Decodable {
    let results: [ResultShort]
}

struct ResultShort: Decodable {
    let imageShort: String
    let description: String
//    let videoShort: String
}

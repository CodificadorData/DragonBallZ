//
//  NewsEntity.swift
//  AppPapple
//
//  Created by Christian Morante on 31/07/25.
//

struct NewsEntity: Decodable {
    let news: [News]
}

struct News: Decodable {
    let title: String
    let description: String
    let imageUrl: String
}

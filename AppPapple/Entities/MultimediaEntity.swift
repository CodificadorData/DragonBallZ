//
//  MultimediaEntity.swift
//  AppPapple
//
//  Created by Christian Morante on 2/08/25.
//

struct MultimediaEntity: Decodable {
    let results: MultimediaEntityResult
}

struct MultimediaEntityResult: Decodable {
    let mangas: [MangaEntity]
    let songs: [SongsEntity]
}

struct MangaEntity: Decodable {
    let mangaImage: String
    let mangaTitle: String
    let mangaPdf: String
}

struct SongsEntity: Decodable {
    let songTitle: String
    let songLink: String
    let songCover: String
    let songBackground: String
}

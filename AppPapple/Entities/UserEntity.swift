//
//  UserEntity.swift
//  AppPapple
//
//  Created by Christian Morante on 13/01/25.
//
struct ResponseUser: Decodable {
    let accessToken: String
    let refreshToken: String
}

struct ResponseRegister: Decodable {
    let code: Int
    let message: String
}

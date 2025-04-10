//
//  UserEntity.swift
//  AppPapple
//
//  Created by Christian Morante on 13/01/25.
//
struct ResponseUser: Decodable {
    let token: String
}

struct UserEntity: Decodable {
    let id: Int
    let name: String
    let surName: String
    let phoneNumber: Int
    let email: String
    let password: String
}

enum UserError: Error {
    case invalidData
}

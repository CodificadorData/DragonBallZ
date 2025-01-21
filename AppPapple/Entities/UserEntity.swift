//
//  UserEntity.swift
//  AppPapple
//
//  Created by Christian Morante on 13/01/25.
//
struct ResponseUser: Decodable {
    var users: UserEntity
}

struct UserEntity: Decodable {
    var id: Int
    var name: String
    var surName: String
    var phoneNumber: Int
    var email: String
    var password: String
}

enum UserError: Error {
    case invalidData
}

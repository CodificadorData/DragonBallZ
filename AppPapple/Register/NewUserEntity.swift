//
//  NewUserEntity.swift
//  AppPapple
//
//  Created by Christian Morante on 7/04/25.
//

struct NewUserEntity: Decodable {
    let name: String
    let surName: String
    let email: String
    let phoneNumber: String
    let imageProfile: String
}

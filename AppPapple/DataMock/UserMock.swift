//
//  UserMock.swift
//  AppPapple
//
//  Created by Christian Morante on 13/01/25.
//
import Foundation

class UserMock {
    
    static var users = """
    {
       "users": [
            {
                "id" : 1,
                "name" : "Christian",
                "surName" : "Morante Santander",
                "phoneNumber" : 933918945,
                "email" : "cris@gmail.com",
                "password" : "123"
            },
            {
                "id" : 2,
                "name" : "Alexander",
                "surName" : "Santander Morante",
                "phoneNumber" : 987987987,
                "email" : "ale@gmail.com",
                "password" : "123"
            },
            {
                "id" : 3,
                "name" : "Jesus",
                "surName" : "Morante Santander",
                "phoneNumber" : 987987987,
                "email" : "jesus@gmail.com",
                "password" : "123"
            },            
            {
                "id" : 4,
                "name" : "Maria",
                "surName" : "Santander Alejos",
                "phoneNumber" : 987987987,
                "email" : "mari@gmail.com",
                "password" : "123"
            },            
            {
                "id" : 5,
                "name" : "Luis",
                "surName" : "Morante Santander",
                "phoneNumber" : "luis@gmail.com",
                "email" : 987123987,
                "password" : "123"
            },
        ]
    }
""".data(using: .utf8)!
    
    static var user = """
    {
       "users": 
            {
                "id" : 1,
                "name" : "Christian",
                "surName" : "Morante Santander",
                "phoneNumber" : 933918945,
                "email" : "cris@gmail.com",
                "password" : "123"
            }
    }
""".data(using: .utf8)!

    
}

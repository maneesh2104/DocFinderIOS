//
//  models.swift
//  DocFind
//
//  Created by Maneesh Sakthivel on 12/15/21.
//

import Foundation

class signIn:Codable{
    let id: String
    let first_name: String
    let username: String
}

class signUpApi: Codable{
    let message: signUp
}

class signUp:Codable{
    let id: String
    let first_name: String
    let username: String
}


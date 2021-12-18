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

class apptAPI: Codable{
    let message: String
}

class signUp:Codable{
    let id: String
    let first_name: String
    let username: String
}

class doctApi: Codable{
    let docs:[Doctors]
}

class Doctors: Codable {
    let name: String
    let address: String
}

class GetApptsAPI: Codable{
    let appts: [Appoinment]
}

class Appoinment: Codable{
    let doc_name: String
    let apt_time: String
}

class User{
    let username: String
    let password: String
    
    init(user:String, pass:String) {
        self.username = user
        self.password = pass
    }
}

var users = [User]()

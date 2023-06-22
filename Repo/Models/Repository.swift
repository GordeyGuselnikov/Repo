//
//  Repo.swift
//  Repo
//
//  Created by Guselnikov Gordey on 6/16/23.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let full_name: String
    let owner: Owner
    
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case fullName = "full_name"
//        case owner = "owner"
//    }
}

struct Owner: Decodable {
    let login: String
    let avatar_url: URL
    let html_url: URL
    let type: String
    
//    enum CodingKeys: String, CodingKey {
//        case login = "login"
//        case avatarURL = "avatar_url"
//        case htmlURL = "html_url"
//        case type = "type"
//    }
}

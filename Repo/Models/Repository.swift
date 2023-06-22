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
}

struct Owner: Decodable {
    let login: String
    let avatar_url: URL
    let html_url: URL
    let type: String
}

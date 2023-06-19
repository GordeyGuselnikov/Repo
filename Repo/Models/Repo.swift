//
//  Repo.swift
//  Repo
//
//  Created by Guselnikov Gordey on 6/16/23.
//

import Foundation

struct Repo: Decodable {
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

enum Link {
    case repoURL
    
    var url: URL {
        switch self {
            
        case .repoURL:
            return URL(string: "https://api.github.com/repositories")!
        }
    }
}

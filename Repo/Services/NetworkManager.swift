//
//  NetworkManager.swift
//  Repo
//
//  Created by Guselnikov Gordey on 6/22/23.
//

import Foundation

enum Link {
    case repositoriesURL
    case usersURL
    case searchRepositoriesURL
    case searchUsersURL
    
    var url: URL {
        switch self {
        case .repositoriesURL:
            return URL(string: "https://api.github.com/repositories")!
        case .usersURL:
            return URL(string: "https://api.github.com/users")!
        case .searchRepositoriesURL:
            return URL(string: "https://api.github.com/search/repositories?q=")!
        case .searchUsersURL:
            return URL(string: "https://api.github.com/search/users?q=")!
        }
    }
}

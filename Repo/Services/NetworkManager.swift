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

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init () {}
    
    func fetchImageData(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}

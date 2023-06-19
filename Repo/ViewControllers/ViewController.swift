//
//  ViewController.swift
//  Repo
//
//  Created by Guselnikov Gordey on 6/16/23.
//

import UIKit

//private let repoURL = "https://api.github.com/repositories"


enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRepos()
    }
    
    // MARK: - Private Methods
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
}

// MARK: - Networking
extension ViewController {
    private func fetchRepos() {
//        guard let url = URL(string: repoURL) else { return }
        URLSession.shared.dataTask(with: Link.repoURL.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let repos = try decoder.decode([Repo].self, from: data)
                print(repos)
                self?.showAlert(withStatus: .success)
            } catch {
                print(error.localizedDescription)
                self?.showAlert(withStatus: .failed)
            }
            
        }.resume()
    }
}


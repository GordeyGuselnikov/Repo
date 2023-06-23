//
//  RepositoryTableViewController.swift
//  Repo
//
//  Created by Guselnikov Gordey on 6/22/23.
//

import UIKit

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
            return "You can see the results in the Debug aria"
        case .failed:
            return "You can see error in the Debug aria"
        }
    }
}

final class RepositoryTableViewController: UITableViewController {
    
    private var repositories: [Repository] = []
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List Repositories"
        tableView.rowHeight = 80
        
        fetchRepositories()
        
        print("Количество репозиториев: \(repositories.count)") //0
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath)
//        guard let cell = cell as? RepositoryTableViewCell else { return UITableViewCell() }
        
        let repository = repositories[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = repository.name
        content.secondaryText = repository.owner.login
        content.image = UIImage(systemName: "bicycle")
        
        print(repository.owner.avatar_url)
        
        networkManager.fetchImageData(from: repository.owner.avatar_url) { [weak self] result in
            switch result {
            case .success(let imageData):
                //TODO: - Не работает content.image
                content.image = UIImage(data: imageData)
                cell.contentConfiguration = content
            case .failure(let error):
                print(error)
                self?.showAlert(withStatus: .failed)
            }
        }
        
        cell.contentConfiguration = content
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
extension RepositoryTableViewController {
    private func fetchRepositories() {
        networkManager.fetch([Repository].self, from: Link.repositoriesURL.url) { [weak self] result in
            switch result {
            case .success(let repos):
                print(repos.count)
                print(repos)
                //self?.showAlert(withStatus: .success)
                self?.repositories = repos
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
                //self?.showAlert(withStatus: .failed)
            }
        }
    }
}

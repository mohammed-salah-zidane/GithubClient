//
//  HomeDataSrc.swift
//  GithubClient
//
//  Created by prog_zidane on 2/7/21.
//

import Foundation

class HomeDataSrc: NSObject {
    var items: [GitHubRepositoryItem] = []
    var onItemSelected: ((IndexPath) -> Void)? = nil
}

extension HomeDataSrc: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as RepoCell
        guard indexPath.row < items.count else {return cell}
        cell.setup(item: items[indexPath.row])
        return cell
    }
}

extension HomeDataSrc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onItemSelected?(indexPath)
    }
}

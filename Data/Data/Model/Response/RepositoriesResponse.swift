//
//  RepositoriesResponse.swift
//  Data
//
//  Created by prog_zidane on 5/2/21.
//

import Foundation

public struct GitHubRepositoryItem: Codable {
    public let id: Int
    public let fullName: String
    public let description: String
    public let stargazersCount: Int
    public let url: URL

    private enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case description
        case stargazersCount = "stargazers_count"
        case url = "html_url"
    }

}

public struct SearchRepositoriesResponse: Codable {
    public let items: [GitHubRepositoryItem]!
}

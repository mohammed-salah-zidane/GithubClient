//
//  RepositoriesRequest.swift
//  Data
//
//  Created by prog_zidane on 5/2/21.
//

import Foundation

public struct SearchRepositoriesRequest: Codable {

    public var q: String!
    public var sort: String!
    public var page: Int!
    public var per_page: Int!
        
    public init(q: String, sort: String = "Stars", page: Int, per_page: Int = 10) {
        self.q = q
        self.sort = sort
        self.page = page
        self.per_page = per_page
    }
}

//
//  UserModel.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//

import Foundation
public struct User: Codable
{
    public var id: String?
    public var name : String?
    
    public init(id: String? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
}


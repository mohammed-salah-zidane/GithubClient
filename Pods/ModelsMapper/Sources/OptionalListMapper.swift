//
// Created by mac on 12/6/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation

public protocol OptionalListMapperProtocol {
    associatedtype I
    associatedtype O
    func map(_ input: [I]?) -> [O]?
}

public struct OptionalListMapper<M: Mapper>: OptionalListMapperProtocol {
    public typealias I = M.I
    public typealias O = M.O

    private let mapper: M

    public init(_ mapper: M) {
        self.mapper = mapper
    }

    /// returns nil if the input nil or empty
    public func map(_ input: [M.I]?) -> [M.O]? {
       input == nil || input!.isEmpty ? nil : input!.map { mapper.map($0) }
    }
}
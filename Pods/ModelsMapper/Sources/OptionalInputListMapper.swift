//
// Created by mac on 12/6/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation

public protocol OptionalInputListMapperProtocol {
    associatedtype I
    associatedtype O
    func map(_ input: [I]?) -> [O]
}

public struct OptionalInputListMapper<M: Mapper>: OptionalInputListMapperProtocol {
    public typealias I = M.I
    public typealias O = M.O

    private let mapper: M

    public init(_ mapper: M) {
        self.mapper = mapper
    }

    /// returns empty if the input is nil
    public func map(_ input: [M.I]?) -> [M.O] {
        input?.map { mapper.map($0) } ?? []
    }
}
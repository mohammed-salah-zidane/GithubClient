//
// Created by mac on 12/6/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation

public protocol Mapper {
    associatedtype I
    associatedtype O
    // returns the desired output
    func map(_ input: I) -> O
}
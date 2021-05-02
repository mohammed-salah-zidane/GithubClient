//
//  DataManager.swift
//  Data
//
//  Created by prog_zidane on 12/13/20.
//

import Foundation
import SwiftyNet

public class DataManager {
    public static func create() -> DataManager { DataManager() }

    public lazy var githubRouter: GithubRepo = {
        GithubRepo(router: NetworkRouter())
    }()
}

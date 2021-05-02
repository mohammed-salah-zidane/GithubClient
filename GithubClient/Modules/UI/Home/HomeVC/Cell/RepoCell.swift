//
//  RepoCell.swift
//  GithubClient
//
//  Created by prog_zidane on 5/2/21.
//

import UIKit

class RepoCell: ConfigurableCell<GitHubRepositoryItem> {

    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    override func setup(item: GitHubRepositoryItem) {
        lbl_Title.text = item.fullName
        lbl_Description.text = item.description
    }
}

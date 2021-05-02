//
//  HomeVM.swift
//  GithubClient
//
//  Created by prog_zidane on 2/7/21.
//

import Foundation

class HomeVM: ViewModel
{
    var isLoading: PublishSubject<Bool>
    var displayError: PublishSubject<String>
    var dataManager: DataManager
    var disposeBag: DisposeBag
    var refreshView = BehaviorRelay<Bool>(value: false)
    
    private var nextCursor: Int = -1

    
    public init(
        dataManager: DataManager
    ) {
        self.disposeBag = DisposeBag()
        self.isLoading = .init()
        self.displayError = .init()
        self.dataManager = dataManager
    }
    
    func getNextCursor() -> Int {
        nextCursor
    }
}

extension HomeVM {
    
}

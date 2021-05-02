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
    var reposFetched = PublishSubject<Bool>()
    
    private var lastRequestItems: Int = -1
    private var repositories = [GitHubRepositoryItem]()
    
    private var searchKey = "Swift"
    
    public init(
        dataManager: DataManager
    ) {
        self.disposeBag = DisposeBag()
        self.isLoading = .init()
        self.displayError = .init()
        self.dataManager = dataManager
    }
    
    func setSearchTerm(text: String) {
        searchKey = text
    }

    func getSearchTerm() -> String {
       searchKey
    }
    
    func getLastRequestItems() -> Int {
        lastRequestItems
    }
    
    func getReposotpries() -> [GitHubRepositoryItem]? {
        repositories
    }
    
    func getRepoUrl(index: Int) -> URL {
        repositories[index].url
    }
}

extension HomeVM {
    
    func search(page: Int = 1) {
        
        if page == 1 {
            isLoading.onNext(true)
        }
        
        let request =  SearchRepositoriesRequest(q: searchKey, page: page)
        
        dataManager
            .githubRouter
            .searchForRepos(request: request)
            .subscribe { [weak self] result in
                guard let self = self else {return}
                self.isLoading.onNext(false)
                switch result {
                case .success(let items):
                    if page == 1 {
                        self.repositories = []
                    }
                    self.updateRepos(repos: items)
                    self.reposFetched.onNext(true)
                case .failure(let error):
                    self.handleError(error: error)
                    self.reposFetched.onNext(false)
                }
                
            } onError: {[weak self] error in
                self?.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    func updateRepos(repos: [GitHubRepositoryItem]) {
        self.lastRequestItems = repos.count
        guard !repositories.isEmpty else {
            self.repositories = repos
            return
        }
        self.repositories.append(contentsOf: repos)
    }
}

//
//  HomeVC.swift
//  GithubClient
//
//  Created by prog_zidane on 2/7/21.
//

import UIKit

class HomeVC: BaseWireframe<HomeVM, Coordinator>  {
    
    //MARK:- Properties
    @IBOutlet weak var tableView: PagedTableView!{
        didSet {
            setupTableView()
        }
    }
    
    //MARK:- Variables
    private lazy var pager: Pager = {
        Pager.Builder()
            .loadMore { [weak self] next in
                guard let self = self else {
                    return
                }
                self.viewModel.search(page: next)
            }
            .withScrollButton()
            .withRefresher()
            .build()
    }()
    
    private lazy var searchManager: SearchManager = {
        SearchManager(viewController: self, delegate: self)
    }()
    
    private lazy var homeDataSrc: HomeDataSrc! = {
        let src = HomeDataSrc()
        src.onItemSelected = { [weak self] indexPath in
            guard let self = self else {
                return
            }
            let url = self.viewModel.getRepoUrl(index: indexPath.row)
            UIApplication.shared.open(url)
        }
        return src
    }()
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:- Ovverides
    override func bind(viewModel: HomeVM) {
        viewModel
            .reposFetched
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
                self?.updateDataSrc()
            }).disposed(by: disposeBag)
    }
}

extension HomeVC {
    
    func updateDataSrc() {
        self.homeDataSrc.items = viewModel.getReposotpries() ?? []
        self.pager.notifyItemsLoaded(count: viewModel.getLastRequestItems())
        self.tableView.tableFooterView = UIView()
    }
    
    func setupTableView() {
        tableView.register(cell: RepoCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.pagedDataSource = homeDataSrc
        tableView.pagedDelegate = homeDataSrc
        tableView.pager = pager
        pager.start()
    }
    
    func setupUI() {
        title = "Github Repositories"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(openSearch))
    }
    
    @objc func openSearch()
    {
        searchManager.presentSearchBar()
    }
}

extension HomeVC: SearchManagerDelegate {
    
    func search(with searchTerm: String) {
        viewModel.setSearchTerm(text: searchTerm)
        pager.start()
    }
    
    func searchBarDidDismissed() {
        viewModel.setSearchTerm(text: "Swift")
        pager.start()
        tableView.updateTableTopInset(top: 0)
    }
    
    func searchBarBeginEditing() {
        tableView.updateTableTopInset(top: 60)
    }
}

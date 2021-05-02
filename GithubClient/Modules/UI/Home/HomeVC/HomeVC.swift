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
                
            }
            .withScrollButton()
            .withRefresher()
            .build()
    }()
    
    private lazy var homeDataSrc: HomeDataSrc! = {
        let src = HomeDataSrc()
        src.onItemSelected = { [weak self] indexPath in
            guard let self = self else {
                return
            }
            
        }
        return src
    }()
    
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- Ovverides
    override func bind(viewModel: HomeVM) {
        
    }
    
}

extension HomeVC {
    
    func updateDataSrc() {
        //self.homeDataSrc.items = viewModel.getFollowers() ?? []
        self.pager.notifyItemsLoaded(count: viewModel.getNextCursor())
        self.tableView.tableFooterView = UIView()
    }
    
    func setupTableView() {
        tableView.register(cell: UserCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.pagedDataSource = homeDataSrc
        tableView.pagedDelegate = homeDataSrc
        tableView.pager = pager
        pager.start()
    }
}

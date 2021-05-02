//
//  SearchManager.swift
//  Presentation
//
//  Created by prog_zidane on 5/2/21.
//

import Foundation
import UIKit

public protocol SearchManagerDelegate:class{
    func search(with searchTerm:String)
    func searchBarDidDismissed()
    func searchBarBeginEditing()
}

public class SearchManager:NSObject {
    private var viewController :UIViewController!
    private weak var delegate: SearchManagerDelegate!
    private var isSearching = false
    private var searchController : UISearchController!
    private var searchTerm = ""
    
    override init() {
        super.init()
    }
    
    public convenience init(
        viewController:UIViewController,
        delegate: SearchManagerDelegate
    ){
        self.init()
        self.viewController = viewController
        self.delegate = delegate
    }
    
    public func presentSearchBar(){
        // Create the search controller and specify that it should present its results in this same view
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        viewController.definesPresentationContext = true
        searchController.loadViewIfNeeded()
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = true
        searchTerm = ""
        isSearching = true
        viewController.present(searchController, animated: true, completion: nil)
    }
}

//MARK: - Conform Search Delegates
extension SearchManager:UISearchControllerDelegate,UISearchBarDelegate,UISearchResultsUpdating{
    
    public func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.delegate.search(with: text)
        }
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //self.delegate.search(with: text)
    }
    
    public func didDismissSearchController(_ searchController: UISearchController) {
        
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            guard let self = self else {return}
            searchController.searchBar.showsCancelButton = false
            searchController.searchBar.resignFirstResponder()
            self.viewController.navigationController!.setNavigationBarHidden(false, animated: true)
        }, completion: {[weak self] finished in
            guard let self = self else {return}
            self.viewController.navigationController!.navigationBar.alpha = 1
            self.delegate.searchBarDidDismissed()
        })
    }
    
    public func willPresentSearchController(_: UISearchController) {
        if #available(iOS 11.0, *) {
            viewController.navigationItem.hidesSearchBarWhenScrolling = false
        }
        viewController.navigationController?.hidesBarsOnSwipe = true
        
    }
    
    public func willDismissSearchController(_ searchController: UISearchController) {
        if #available(iOS 11.0, *) {
            viewController.navigationItem.hidesSearchBarWhenScrolling = true
        }
        viewController.navigationController?.hidesBarsOnSwipe = false
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            guard let self = self else {return}
            searchBar.showsCancelButton = true
            self.viewController.navigationController?.setNavigationBarHidden(true, animated: true)
        }, completion: {[weak self] value in
            guard let self = self else {return}

            self.viewController.navigationController!.navigationBar.alpha = 0
            self.delegate.searchBarBeginEditing()
        })
        return true
    }
    
    
}


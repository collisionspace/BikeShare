//
//  SearchBarView.swift
//  BikeShare
//
//  Created by SLONE, Daniel on 4/3/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import UIKit

protocol SearchBarDelegate {
    func textDidChange(searchText: String)
    func isSearchBar(active: Bool)
}
class SearchBarView: UIView, UISearchBarDelegate {
    
    let searchBar: UISearchBar
    var searchBarDelegate: SearchBarDelegate?
    //var onTextChange: ((SearchBar) -> Void)?
    
    init(customSearchBar: UISearchBar) {
        searchBar = customSearchBar
        super.init(frame: CGRect.zero)
        
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.barTintColor = UIColor.white
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .done
        addSubview(searchBar)
    }
    
    override convenience init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar())
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print("should end ")
        searchBarDelegate?.isSearchBar(active: false)
        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("should begin")
        searchBarDelegate?.isSearchBar(active: true)
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("did end")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarDelegate?.textDidChange(searchText: searchText)
    }
}

//
//  ViewController.swift
//  Git-Repositories-Search
//
//  Created by AbdulrhmanNoon on 5/9/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
       setupViews()
    }
    
    private func setupViews() {
        searchBar.showsCancelButton = true
        searchBar.delegate = self
    
    }
}


// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = SearchResultViewController(searchText: searchBar.text ?? "")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

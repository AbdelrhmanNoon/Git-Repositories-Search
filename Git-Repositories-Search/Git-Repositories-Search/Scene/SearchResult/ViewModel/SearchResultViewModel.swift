//
//  SearchResultViewModel.swift
//  Git-Repositories-Search
//
//  Created by AbdulrhmanNoon on 7/17/21.
//

import Foundation
import PromiseKit
import Moya

class SearchResultViewModel: NSObject {
    // MARK: - Properties
    private(set) var repositories: [SearchResultModel]! {
           didSet {
               self.bindItemsViewModelToController()
           }
       }
    var currentPage = 1
    var totalCount: Int = 0
    
    // MARK: - Bindings
    var bindItemsViewModelToController : (() -> Void) = {}
    var showLoader: (() -> Void)?
    var hideLoader: (() -> Void)?
    
    override init() {
        super.init()
        repositories = []
    }

    func getRepositoriesListFor(text: String) {
        self.showLoader?()
        NetworkManager.shared.getRepositoriesList(text: text,
                                                  page: currentPage) { (result) in
            self.hideLoader?()
            switch result {
            case .success(let list):
                self.totalCount = list.total_count
                self.repositories.append(contentsOf: list.items ?? [])
            case .failure(let error):
                // Should handleing Error: show error Alert
                print(error)
            }
        }
    }
    
    
    func willDisplayRepositories(with text: String) {
        getRepositoriesListFor(text: text)
    }
}


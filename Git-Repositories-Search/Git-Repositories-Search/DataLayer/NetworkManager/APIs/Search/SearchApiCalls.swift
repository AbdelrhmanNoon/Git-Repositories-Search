//
//  SearchApiCalls.swift
//  Git-Repositories-Search
//
//  Created by AbdulrhmanNoon on 7/17/21.
//

import Foundation
import Moya
import RxSwift

extension NetworkManager {
    func getRepositoriesList(text: String,
                             page: Int,
                             completion: @escaping (
                            _ result: Swift.Result<ListResponse<SearchResultModel>, Error>) -> Void) {
        
        self.provider.request(MultiTarget(SearchApis.getSearchResultsFor(searchText: text, andPageNumber: page))) { (result) in
            self.parseListResponse(moyaResult: result, completion: completion)
        }
    }
    
}

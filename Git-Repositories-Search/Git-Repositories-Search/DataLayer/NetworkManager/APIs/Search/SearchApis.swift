//
//  SearchApis.swift
//  Git-Repositories-Search
//
//  Created by AbdulrhmanNoon on 7/17/21.
//

import Foundation
import Moya

enum  SearchApis {
    case getSearchResultsFor(searchText: String, andPageNumber: Int)
}

extension SearchApis: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getSearchResultsFor:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSearchResultsFor:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
   // ?q="test"&type=users&page=1

    var task: Task {
        switch self {
        case .getSearchResultsFor(let searchText,
                                  let page):
            return .requestParameters(
                parameters: [ "q": searchText,
                              "page": page],
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        .none
    }
    
    var authorizationType: AuthorizationType? {
        return .bearer
    }
}

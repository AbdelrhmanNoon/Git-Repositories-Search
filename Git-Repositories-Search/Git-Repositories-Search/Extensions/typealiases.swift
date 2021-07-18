//
//  typealiases.swift
//  Git-Repositories-Search
//
//  Created by AbdulrhmanNoon on 7/17/21.
//

import Foundation
import Moya

typealias MoyaCompletion = (Result<Moya.Response, MoyaError>)
typealias NetworkComplationForList<T: Codable> = (
    _ result: Swift.Result<ListResponse<T>, Error>) -> Void

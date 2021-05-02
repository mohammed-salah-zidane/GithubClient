//
//  GithubAPI.swift
//  Data
//
//  Created by prog_zidane on 5/2/21.
//

import Foundation
import SwiftyNet
import Alamofire

enum GithubAPI {
    case search(request: SearchRepositoriesRequest)
}

extension GithubAPI: NetworkRequest {
    
    var path: String {
        switch self {
        case .search:
            return "/search/repositories"
        }
    }
    
    var baseUrl: URL {
        return Environments.shared.baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let request):
            var params = [String: Any]()
            params["q"] = request.q
            params["sort"] = request.sort
            params["page"] = "\(request.page!)"
            params["per_page"] = request.per_page
            return params
        }
    }
    
    var parameterEncoding: RequestParameterEncoding? {
        switch self {
        case .search:
            return .queryString
        }
    }
}

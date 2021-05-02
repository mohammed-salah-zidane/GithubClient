//
//  GithubRemoteDataSrc.swift
//  Data
//
//  Created by prog_zidane on 5/2/21.
//

import Foundation
import RxSwift
import SwiftyNet
import RxCocoa

public class GithubRepo {
    
    let router: NetworkRouter!
    
    public init(router: NetworkRouter) {
        self.router = router
    }

    public func searchForRepos(
        request: SearchRepositoriesRequest
    )-> Observable<Result<[GitHubRepositoryItem],NetworkError>> {
        
        Observable<Result<[GitHubRepositoryItem],NetworkError>>.create {[unowned self] observer in
            
            let targetRequest = GithubAPI.search(request: request)

            self.router.request(
                targetRequest: targetRequest,
                responseObject: SearchRepositoriesResponse.self) { result in
                switch result {
                case .success(let data):
                    observer.onNext(.success(data.items))
                case .failure(let error):
                    observer.onNext(.failure(error))
                @unknown default:
                    break
                }
            }
            return Disposables.create()
        }
    }
}

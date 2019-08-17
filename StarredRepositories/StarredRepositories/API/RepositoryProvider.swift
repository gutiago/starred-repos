//
//  RepositoryProvider.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import Moya
import Alamofire
import RxSwift

struct RepositoryProvider {
    
    private static let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return SessionManager(configuration: configuration)
    }()
    
    private let gitProvider = MoyaProvider<GitAPI>(manager: sessionManager)
    
    // MARK: - Access
    func searchStarredRepositories(atPage page: Int, andSearchSize searchsize: Int) -> Observable<[Repository]> {
        let params = getFullRequestParams(page, searchsize: searchsize)
        
        return gitProvider.rx
            .request(.repositories(params: params))
            .map(GitResult.self)
            .map({ $0.items })
            .asObservable()
    }

    private func getFullRequestParams(_ page: Int, searchsize: Int) -> [String: Any] {
        var parameters = [String: Any]()
        parameters["q"] = "language:swift"
        parameters["sort"] = "stars"
        parameters["page"] = page
        parameters["per_page"] = searchsize
        
        return parameters
    }
}

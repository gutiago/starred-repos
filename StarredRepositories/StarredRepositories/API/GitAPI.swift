//
//  GitAPI.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import Moya

enum GitAPI: TargetType {
    case repositories(params: [String: Any])
    
    var baseURL: URL {
        guard let gitURL = URL(string: "https://api.github.com/search") else {
            fatalError("Git url could not be created")
        }
        
        return gitURL
    }
    
    var path: String {
        return "/repositories"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .repositories(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "User-Agent": "request"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

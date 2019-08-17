//
//  Repository.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    
    let name: String
    let stargazers_count: Int
    let owner: Owner
    
}

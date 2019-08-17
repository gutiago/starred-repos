//
//  GitResult.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import Foundation

struct GitResult: Decodable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Repository]
}

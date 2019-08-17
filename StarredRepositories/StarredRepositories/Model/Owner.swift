//
//  Owner.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    
    let avatar_url: String
    let login: String
    
    var photoUrl: URL? {
        return URL(string: avatar_url)
    }
}

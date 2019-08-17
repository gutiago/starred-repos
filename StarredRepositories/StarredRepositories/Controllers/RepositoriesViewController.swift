//
//  ViewController.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {

    let repo = RepositoryProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repo.searchStarredRepositories(atPage: 1, andSearchSize: 10).subscribe(onNext: { (repos) in
            print(repos)
        }, onError: { (error) in
            print(error)
        })
    }
}


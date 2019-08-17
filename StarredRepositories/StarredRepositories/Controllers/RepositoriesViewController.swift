//
//  ViewController.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {

    private let viewModel = RepositoriesVM()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    var repositoryView: RepositoryView {
        return self.view as! RepositoryView
    }
    
    override func loadView() {
        view = RepositoryView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindContent()
    }
    
    // MARK: - Bind
    private func bindContent() {
        repositoryView.bindTable(viewModel.repositoryObservable)
        repositoryView.bindModelState(viewModel.stateDriver)
        viewModel.bindViewState(repositoryView.stateObservable)
    }
}


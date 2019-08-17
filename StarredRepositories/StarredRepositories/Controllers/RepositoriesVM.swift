//
//  RepositoriesVM.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import RxSwift
import RxCocoa

class RepositoriesVM: NSObject {
    
    enum State {
        case initial, loading, loaded, failed
    }
    
    // MARK: - Output
    var repositoryObservable: Observable<[Repository]> {
        return repositories.asObservable()
    }
    
    private let repositories = BehaviorRelay<[Repository]>(value: [])
    private let state = BehaviorRelay<State>(value: .initial)
    
    private let repositoryProvider = RepositoryProvider()
    private let disposeBag = DisposeBag()
    private let SEARCH_SIZE = 30
    private let MAX_SEARCH_THRESHOLD = 1000
    
    private var currentPage = 0
    private var isLoading = false
    
    // MARK: - Load
    func loadContent() {
        guard shouldLoadMore() else {
            return
        }
        
        state.accept(.loading)
        
        repositoryProvider
            .searchStarredRepositories(atPage: currentPage, andSearchSize: SEARCH_SIZE)
            .subscribe(onNext: { [weak self] (repositories) in
                self?.handleLoadSuccess(repositories)
                }, onError: { [weak self] (error) in
                    self?.handleLoadError(error)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Aux
    private func shouldLoadMore() -> Bool {
        let reachedThreshold = self.repositories.value.count >= MAX_SEARCH_THRESHOLD
        let isLoading = (state.value == .loading)
        return !reachedThreshold && !isLoading
    }
    
    private func handleLoadSuccess(_ repos: [Repository]) {
        let content = repositories.value + repos
        repositories.accept(content)
        state.accept(.loaded)
    }
    
    private func handleLoadError(_ error: Error) {
        print("Loading error \(error)")
        
        if repositories.value.count == 0 {
            state.accept(.failed)
        }
    }
    
}

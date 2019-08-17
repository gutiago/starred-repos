//
//  RepositoriesVM.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import RxSwift
import RxCocoa

enum State {
    case none, loading, loaded, failed
}

class RepositoriesVM: NSObject {
    
    // MARK: - Output
    var repositoryObservable: Driver<[Repository]> {
        return repositories.asDriver()
    }
    
    var stateDriver: Driver<State> {
        return state.asDriver()
    }
    
    private let repositories = BehaviorRelay<[Repository]>(value: [])
    private let state = BehaviorRelay<State>(value: .none)
    
    private let repositoryProvider = RepositoryProvider()
    private let disposeBag = DisposeBag()
    private let SEARCH_SIZE = 30
    private let MAX_SEARCH_THRESHOLD = 1000
    
    private var currentPage = 0
    private var isLoading = false
    
    // MARK: - Load
    func bindViewState(_ observable: Observable<RepositoryView.ViewState>) {
        loadContent()
        
        observable.subscribe(onNext: { [unowned self] (state) in
            self.performAction(forViewState: state)
        })
        .disposed(by: disposeBag)
    }
    
    private func loadContent() {
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
    private func performAction(forViewState state: RepositoryView.ViewState) {
        switch state {
        case .loadMore:
            self.loadContent()
        case .refresh:
            self.currentPage = 1
            self.loadContent()
        default:
            self.loadContent()
        }
    }
    
    private func shouldLoadMore() -> Bool {
        let reachedThreshold = self.repositories.value.count >= MAX_SEARCH_THRESHOLD
        let isLoading = (state.value == .loading)
        return !reachedThreshold && !isLoading
    }
    
    private func handleLoadSuccess(_ repos: [Repository]) {
        let content: [Repository]
        
        if currentPage == 1 {
            content = repos
        } else {
            content = repositories.value + repos
        }
        
        currentPage += 1
        
        repositories.accept(content)
        state.accept(.loaded)
    }
    
    private func handleLoadError(_ error: Error) {
        print("Loading error \(error)")
        
        if repositories.value.count == 0 {
            state.accept(.failed)
        } else {
            state.accept(.none)
        }
    }
    
}

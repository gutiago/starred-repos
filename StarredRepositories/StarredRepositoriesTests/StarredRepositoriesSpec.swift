//
//  StarredRepositoriesSpec.swift
//  StarredRepositoriesTests
//
//  Created by Gustavo Tiago on 18/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import StarredRepositories

class StarredRepositoriesSpecs: QuickSpec {
    override func spec() {
        var viewModel: RepositoriesVM!
        var viewState: PublishSubject<RepositoryView.ViewState>!
        
        describe("fetch") {
            beforeEach {
                viewModel = RepositoriesVM()
                viewState = PublishSubject<RepositoryView.ViewState>()
                viewModel.bindViewState(viewState.asObserver())
            }
            
            context("for the first time") {
                it("has the initial items") {
                    expect(viewModel.repositoriesCount).toEventually(equal(30), timeout: 5)
                }
            }
        }
        
        describe("load more") {
            beforeEach {
                viewModel = RepositoriesVM()
                viewState = PublishSubject<RepositoryView.ViewState>()
                viewModel.bindViewState(viewState.asObserver())
            }
            
            context("for scroll") {
                it("has the new items") {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        viewState.onNext(.loadMore)
                    }
                    
                    expect(viewModel.repositoriesCount).toEventually(equal(60), timeout: 20.0)
                }
            }
        }
    }
}

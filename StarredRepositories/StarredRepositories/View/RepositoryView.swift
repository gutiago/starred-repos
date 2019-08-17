//
//  RepositoryView.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class RepositoryView: UIView {
    
    enum ViewState {
        case refresh, loadMore, tryAgain
    }
    
    var stateObservable: Observable<ViewState> {
        return viewState.asObservable()
    }
    
    private let viewState = PublishSubject<ViewState>()
    
    private let refreshControl = UIRefreshControl()
    private let tableView = UITableView()
    private let vNoInternet = NoInternetView()
    private let ivLoading: UIImageView = {
        let image = UIImage(named: "ic-loading")
        return UIImageView(image: image)
    }()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        createSubviews()
        bindOffset()
    }
    
    // MARK: - Layout
    private func createSubviews() {
        setupSubviews()
        
        self.addSubview(tableView)
        self.addSubview(ivLoading)
        self.addSubview(vNoInternet)
        
        addConstraints()
    }
    
    private func setupSubviews() {
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.Identifier)
        tableView.rowHeight = 80.0
        tableView.estimatedRowHeight = 80.0
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        
        ivLoading.isHidden = true
        ivLoading.contentMode = .scaleAspectFit
        
        vNoInternet.isHidden = true
        vNoInternet.layer.shadowRadius = 15.0
        vNoInternet.layer.shadowColor = UIColor.black.cgColor
        vNoInternet.layer.shadowOpacity = 0.15
        vNoInternet.layer.cornerRadius = 20.0
        vNoInternet.btnNoInternet.addTarget(self, action: #selector(tryAgainPressed), for: .touchUpInside)
    }
    
    private func addConstraints() {
        tableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            maker.left.equalTo(self)
            maker.right.equalTo(self)
        }
        
        ivLoading.snp.makeConstraints { (maker) in
            maker.center.equalTo(self)
            maker.width.equalTo(20.0)
            maker.height.equalTo(20.0)
        }
        
        vNoInternet.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self)
            maker.centerX.equalTo(self)
            maker.width.equalTo(self).inset(20.0).priority(999)
        }
    }
    
    //MARK: - Actions
    @objc private func tryAgainPressed() {
        self.viewState.onNext(.tryAgain)
    }
    
    // MARK: - Bind
    
    func bindTable(_ driver: Driver<[Repository]>) {
        driver
            .do(onNext: { [unowned self] (_) in
                self.refreshControl.endRefreshing()
            })
            .drive(tableView
            .rx
            .items(cellIdentifier: RepositoryCell.Identifier,
                   cellType: RepositoryCell.self)) {
                    _, repository, cell in
                    cell.configure(repository)
            }
            .disposed(by: disposeBag)
    }
    
    func bindModelState(_ driver: Driver<State>) {
        driver
            .map({ [unowned self] in self.isLoadingHidden(forState: $0) })
            .drive(ivLoading.rx.isHidden)
            .disposed(by: disposeBag)
        
        driver
            .drive(onNext: { [unowned self] (state) in
                self.isLoadingHidden(forState: state) ? self.ivLoading.stopRotating() : self.ivLoading.rotate()
            })
            .disposed(by: disposeBag)
        
        driver
            .map({ $0 != .failed })
            .drive(vNoInternet.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    private func bindOffset() {
        tableView.rx
            .contentOffset
            .asDriver()
            .drive(onNext: { [unowned self] (offSet) in
                
                if self.isNearBottomEdge(contentOffset: offSet) {
                    self.viewState.onNext(.loadMore)
                }
                
            }).disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged).subscribe(onNext: { [unowned self] (_) in
            self.viewState.onNext(.refresh)
        }).disposed(by: disposeBag)
    }
    
    private func isLoadingHidden(forState state: State) -> Bool {
        let isLoading = (state == .loading)
        let isEmptyTable = (tableView.numberOfRows(inSection: 0) == 0)
        let showLoading = isLoading && isEmptyTable
        return !showLoading
    }
    
    private func isNearBottomEdge(contentOffset: CGPoint) -> Bool {
        let contentSize = tableView.contentSize
        let calculatedSize = contentOffset.y + self.frame.size.height
        return calculatedSize > contentSize.height
    }
    
}

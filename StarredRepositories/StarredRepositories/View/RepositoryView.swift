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

    let tableView = UITableView()
    let ivLoading: UIImageView = {
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
    }
    
    // MARK: - Layout
    private func createSubviews() {
        self.addSubview(tableView)
        self.addSubview(ivLoading)
        
        tableView.rowHeight = 80.0
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.Identifier)
        
        ivLoading.isHidden = true
        ivLoading.contentMode = .scaleAspectFit
        
        addConstraints()
    }
    
    private func addConstraints() {
        tableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
            maker.left.equalTo(self)
            maker.right.equalTo(self)
        }
        
        ivLoading.snp.makeConstraints { (maker) in
            maker.center.equalTo(self)
            maker.width.equalTo(20.0)
            maker.height.equalTo(20.0)
        }
    }
    
    // MARK: - Bind
    func bindTable(_ observable: Observable<[Repository]>) {
        observable.bind(to: tableView
                .rx
                .items(cellIdentifier: RepositoryCell.Identifier,
                       cellType: RepositoryCell.self)) {
                        _, repository, cell in
                        cell.configure(repository)
            }
            .disposed(by: disposeBag)
        
    }

}



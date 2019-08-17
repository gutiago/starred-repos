//
//  NoInternetView.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 17/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import UIKit
import SnapKit

class NoInternetView: UIView {
    
    let contentStack = UIStackView()
    
    let labelsStack = UIStackView()
    let lblTitle = UILabel()
    let lblSubtitle = UILabel()
    
    let btnNoInternet = UIButton()
    
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
    
    private func createSubviews() {
        setupSubviews()
        
        addSubview(contentStack)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        contentStack.snp.makeConstraints { (maker) in
            maker.left.equalTo(self).inset(20.0)
            maker.right.equalTo(self).inset(20.0)
            maker.top.equalTo(self).inset(20.0)
            maker.bottom.equalTo(self).inset(20.0)
        }
        
        btnNoInternet.snp.makeConstraints { (maker) in
            maker.height.equalTo(70.0)
        }
    }
    
    private func setupSubviews() {
        labelsStack.addArrangedSubview(lblTitle)
        labelsStack.addArrangedSubview(lblSubtitle)
        
        contentStack.addArrangedSubview(labelsStack)
        contentStack.addArrangedSubview(btnNoInternet)
        
        labelsStack.axis = .vertical
        labelsStack.spacing = 3.0
        
        contentStack.axis = .vertical
        contentStack.spacing = 20.0
        
        lblTitle.font = UIFont.Quicksand.medium.size(20.0)
        lblTitle.textAlignment = .center
        lblTitle.text = "SEM INTERNET"
        
        lblSubtitle.font = UIFont.Quicksand.regular.size(18.0)
        lblSubtitle.text = "Verifique sua conexão e tente novamente."
        lblSubtitle.textAlignment = .center
        lblSubtitle.adjustsFontSizeToFitWidth = true
        lblSubtitle.numberOfLines = 2
        
        btnNoInternet.titleLabel?.font = UIFont.Quicksand.medium.size(18.0)
        btnNoInternet.setTitleColor(.black, for: .normal)
        btnNoInternet.setTitle("Tentar Novamente", for: .normal)
        
        btnNoInternet.layer.borderColor = UIColor.black.cgColor
        btnNoInternet.layer.borderWidth = 1.0
        btnNoInternet.layer.cornerRadius = 35.0
    }
}

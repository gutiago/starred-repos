//
//  RepositoryCell.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class RepositoryCell: UITableViewCell {

    static let Identifier = "RepositoryCell"
    
    let ivAuthor = UIImageView()
    
    let infoStack = UIStackView()
    let lblRepositoryName = UILabel()
    let lblAuthorName = UILabel()
    
    let starStack = UIStackView()
    let lblStarCount = UILabel()
    let ivStar: UIImageView = {
        let image = UIImage(named: "star")
        return UIImageView(image: image)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createSubviews()
    }
    
    func configure(_ repository: Repository) {
        ivAuthor.kf.setImage(with: repository.owner.photoUrl)
        
        lblRepositoryName.text = repository.name
        lblAuthorName.text = repository.owner.login
        
        lblStarCount.text = String(repository.stargazers_count)
    
    }
    
    // MARK: - Setup
    private func createSubviews() {
        self.addSubview(ivAuthor)
        
        self.infoStack.addArrangedSubview(lblRepositoryName)
        self.infoStack.addArrangedSubview(lblAuthorName)
        self.addSubview(infoStack)
        
        self.starStack.addArrangedSubview(ivStar)
        self.starStack.addArrangedSubview(lblStarCount)
        self.addSubview(starStack)
        
        self.setupLayout()
        self.addConstraints()
    }
    
    private func setupLayout() {
        infoStack.spacing = 5.0
        infoStack.axis = .vertical
        
        starStack.spacing = 5.0
        starStack.axis = .vertical
        
        ivAuthor.layer.cornerRadius = 25.0
        ivAuthor.clipsToBounds = true
        
        lblRepositoryName.font = UIFont.Quicksand.medium.size(20.0)
        lblAuthorName.font = UIFont.Quicksand.medium.size(18.0)
        lblStarCount.font = UIFont.Quicksand.medium.size(15.0)
        
        lblRepositoryName.adjustsFontSizeToFitWidth = true
        lblAuthorName.adjustsFontSizeToFitWidth = true
        lblStarCount.adjustsFontSizeToFitWidth = true
        
        ivAuthor.contentMode = .scaleAspectFit
        ivStar.contentMode = .scaleAspectFit
    }
    
    private func addConstraints() {
        ivAuthor.snp.makeConstraints { (maker) in
            maker.width.equalTo(50.0)
            maker.height.equalTo(50.0)
            maker.centerY.equalTo(self)
            maker.left.equalTo(self).offset(10.0)
            maker.top.greaterThanOrEqualTo(self).offset(10.0)
            maker.bottom.greaterThanOrEqualTo(self).offset(10.0)
        }
        
        infoStack.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self)
            maker.left.equalTo(ivAuthor).offset(15.0)
            maker.top.greaterThanOrEqualTo(self).offset(10.0)
            maker.bottom.greaterThanOrEqualTo(self).offset(10.0)
        }
        
        starStack.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self)
            maker.left.equalTo(infoStack).offset(15.0)
            maker.right.equalTo(infoStack).offset(10.0)
            maker.top.greaterThanOrEqualTo(self).offset(10.0)
            maker.bottom.greaterThanOrEqualTo(self).offset(10.0)
        }
    }

}

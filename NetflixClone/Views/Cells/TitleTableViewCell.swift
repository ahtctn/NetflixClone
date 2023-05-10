//
//  TitleTableViewCell.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 10.05.2023.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let id: String = "TitleTableViewCell"
    
    private let titlesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let titlePosterUIImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterUIImageView)
        contentView.addSubview(titlesLabel)
        contentView.addSubview(playTitleButton)
        
        self.applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
         let titlesPosterUIImageViewConstraints = [
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
         ]
        
        let titlesLabelConstraints = [
            titlesLabel.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 20),
            titlesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titlesLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    
    public func configure(with model: TitleViewModel) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        
        titlePosterUIImageView.sd_setImage(with: url, completed: nil)
        titlesLabel.text = model.titleName
        
        
    }
    
    
    
}

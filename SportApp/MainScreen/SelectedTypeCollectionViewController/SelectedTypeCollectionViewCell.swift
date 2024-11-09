//
//  SelectedTypeCollectionViewCell.swift
//  SportApp
//
//  Created by Кирилл Бахаровский on 11/9/24.
//

import UIKit

class SelectedTypeCollectionViewCell: UICollectionViewCell {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Example"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        textLabel.text = text
    }
}

extension SelectedTypeCollectionViewCell {
    private func setupViews(){
        contentView.addSubview(textLabel)
        
        
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 16
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}




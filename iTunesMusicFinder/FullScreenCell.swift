//
//  FullScreenCell.swift
//  iTunesMusicFinder
//
//  Created by Георгий on 18.03.2022.
//

import UIKit

class FullScreenCell: UITableViewCell {
    static let identifier = "FullScreenCell"
    let mainLabel: UILabel = {
        var mainLabel = UILabel()
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.textAlignment = .center
        mainLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        mainLabel.textColor = .darkGray
        return mainLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainLabel)
        addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}

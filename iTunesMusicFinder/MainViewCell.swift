//
//  MainViewCell.swift
//  iTunesMusicFinder
//
//  Created by Георгий on 18.03.2022.
//

import UIKit

class MainViewCell: UITableViewCell {
    static let identifier = "MainViewCell"
    let albumImageView: UIImageView = {
        let albumImageView = UIImageView()
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.contentMode = .scaleAspectFit
        albumImageView.layer.cornerRadius = 15
        albumImageView.backgroundColor = .white
        albumImageView.layer.masksToBounds = true
        return albumImageView
    }()
    let albumNameLabel: UILabel = {
        let albumNameLabel = UILabel()
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.text = "albumName"
        albumNameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        return albumNameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(albumImageView)
        addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            albumImageView.widthAnchor.constraint(equalToConstant: 30),
            albumImageView.heightAnchor.constraint(equalToConstant: 30),
            
            albumNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            albumNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 10),
            albumNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            contentView.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    func configure(with album: Album) {
        albumNameLabel.text = "\(album.artistName) - \(album.albumName)"
        
        if let imageURL = URL(string: album.artworkUrl100) {
            let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.albumImageView.image = UIImage.init(data: data)
                    }
                }
            }
            task.resume()
        }
    }
}

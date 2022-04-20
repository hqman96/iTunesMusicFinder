//
//  AlbumHeader.swift
//  iTunesMusicFinder
//
//  Created by Георгий on 18.03.2022.
//

import UIKit

final class AlbumHeader: UITableViewHeaderFooterView {
    static let identifier = "AlbumHeader"
    
    private let albumImageView: UIImageView = {
        let albumImageView = UIImageView()
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.contentMode = .scaleAspectFit
        albumImageView.layer.cornerRadius = 50
        albumImageView.backgroundColor = UIColor(red: 140 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1.0)
        albumImageView.layer.masksToBounds = true
        return albumImageView
    }()
    
    private let albumNameLabel: UILabel = {
        let albumNameLabel = UILabel()
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.numberOfLines = 0
        albumNameLabel.text = "albumName"
        albumNameLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        albumNameLabel.textAlignment = .center
        return albumNameLabel
    }()
    
    private let artistNameLabel: UILabel = {
        let artistNameLabel = UILabel()
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.numberOfLines = 0
        artistNameLabel.text = "artistName"
        artistNameLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        artistNameLabel.textAlignment = .center
        return artistNameLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(albumImageView)
        contentView.backgroundColor = UIColor(red: 140 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1.0)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(albumName: String, artistName: String, albumImage: UIImage?) {
        albumNameLabel.text = albumName
        artistNameLabel.text = artistName
        albumImageView.image = albumImage
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            albumImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            albumImageView.widthAnchor.constraint(equalToConstant: 100),
            albumImageView.heightAnchor.constraint(equalToConstant: 100),
            
            albumNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 10),
            albumNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            albumNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 10),
            artistNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

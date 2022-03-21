//
//  AlbumViewController.swift
//  iTunesMusicFinder
//
//  Created by Георгий on 17.03.2022.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private let tracklistTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(AlbumHeader.self, forHeaderFooterViewReuseIdentifier: "AlbumHeader")
        return table
    }()
    private var tracks: [Track] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tracklistTableView.reloadData()
            }
        }
    }
    var albumImage: UIImage? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tracklistTableView.reloadData()
            }
        }
    }
    let tracksUrl = "https://itunes.apple.com/lookup?entity=song&id="
    let album: Album
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbumImage()
        loadTracks()
        view.addSubview(tracklistTableView)
        NSLayoutConstraint.activate([
            tracklistTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tracklistTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tracklistTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tracklistTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        tracklistTableView.dataSource = self
        tracklistTableView.delegate = self
    }
    func getAlbumImage() {
        if let imageURL = URL(string: album.artworkUrl100) {
            let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data {
                    self.albumImage = UIImage.init(data: data)
                }
            }
            task.resume()
        }
    }
    func loadTracks() {
        if let url = URL(string: "\(tracksUrl)\(album.collectionId)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let trackData = try decoder.decode(TrackDataModel.self, from: data)
                        self.tracks = trackData.results
                        //In response to the url request, the first element is not a track and contains only the name of the artist
                        self.tracks.removeFirst()
                    }
                    catch {
                        print("error")
                    }
                }
            }
            task.resume()
        }
    }
}
extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AlbumHeader") as? AlbumHeader
        header?.configure(albumName: album.albumName, artistName: album.artistName, albumImage: albumImage)
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(String(describing: tracks[indexPath.row].artistName)) - \(tracks[indexPath.row].trackName ?? "Unnamed")"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

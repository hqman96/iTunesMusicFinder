//
//  ViewController.swift
//  iTunesMusicFinder
//
//  Created by Георгий on 15.03.2022.
//

import UIKit

final class MainViewController: UIViewController {
    private let albumsUrl =  "https://itunes.apple.com/search?entity=album&offset=0&limit=100&term="
    
    private var albums: [Album] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.mainTableView.reloadData()
            }
        }
    }
    
    private var searchTask: URLSessionDataTask?
    
    @IBOutlet weak var albumSearchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumSearchBar.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
        mainTableView.register(FullScreenCell.self, forCellReuseIdentifier: FullScreenCell.identifier)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if albums.count > 0 {
            let album = albums[indexPath.row]
            let detailsVC = AlbumViewController.init(album: album)
            present(detailsVC, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        albums.count > 0 ? 35 : mainTableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count > 0 ? albums.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if albums.count > 0 {
            if indexPath.row < albums.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier) as! MainViewCell
                let album = albums[indexPath.row]
                cell.configure(with: album)
                return cell
            } else {
                return UITableViewCell()
            }
        } else if albumSearchBar.text?.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FullScreenCell.identifier) as! FullScreenCell
            cell.mainLabel.text = "Введите запрос"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FullScreenCell.identifier) as! FullScreenCell
            cell.mainLabel.text = "Нет результатов"
            return cell
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            albums = []
        } else {
            if let urlString = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if let searchUrl = URL(string: "\(albumsUrl)\(urlString)") {
                    searchTask?.cancel()
                    searchTask = URLSession.shared.dataTask(with: searchUrl) { data, response, error in
                        if let data = data {
                            let decoder = JSONDecoder()
                            do {
                                let albumData = try decoder.decode(AlbumDataModel.self, from: data)
                                self.albums = albumData.results
                            }
                            catch {
                                print("error")
                            }
                        }
                    }
                    searchTask?.resume()
                }
            }
        }
        self.mainTableView.reloadData()
    }
}

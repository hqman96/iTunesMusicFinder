//
//  ViewController.swift
//  iTunesMusicFinder
//
//  Created by Георгий on 15.03.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let url =  "https://itunes.apple.com/search?entity=album&offset=0&limit=100&term="
    var albums: [Album] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.mainTableView.reloadData()
            }
        }
    }
    var searchTask: URLSessionDataTask?
    
    @IBOutlet weak var albumSearchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumSearchBar.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

extension MainViewController: UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            albums = []
        }
        else {
            if let urlString = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if let searchUrl = URL(string: "\(url)\(urlString)") {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if albums.count > 0 {
            let album = albums[indexPath.row]
            let detailsVC = AlbumViewController.init(album: album)
            present(detailsVC, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = albums[indexPath.row].albumName
        return cell
    }
}

//
//  ViewController.swift
//  iTunesMusicFinder
//
//  Created by Георгий on 15.03.2022.
//

import UIKit

class MainViewController: UIViewController {

    var albums = ["album 1","album 2","album 3","album 4"]
    var foundAlbums: [String]!
   
    @IBOutlet weak var albumSearchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumSearchBar.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self
        foundAlbums = albums
    }
}

extension MainViewController: UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        foundAlbums = []
        if searchText == "" {
            foundAlbums = albums
        }
        else {
            for album in albums {
                if album.lowercased().contains(searchText.lowercased()) {
                    foundAlbums.append(album)
                }
            }
            self.mainTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundAlbums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = foundAlbums[indexPath.row]
        return cell
    }
}

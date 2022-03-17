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
        return table
    }()
    private var tracks = ["track 1","track 2","track 3","track 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}
extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tracks[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//
//  ViewController.swift
//  iTunesMusicFinder
//
//  Created by Георгий on 15.03.2022.
//

import UIKit

class MainViewController: UIViewController {

    var albums = ["album 1","album 2","album 3","album 4"]
    
    @IBOutlet weak var albumSearchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = albums[indexPath.row]
        return cell
    }
}

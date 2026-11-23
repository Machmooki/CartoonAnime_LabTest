//
//  AnimeListTableViewController.swift
//  CartoonAnime_LabTest
//
//  Created by Mach Suwanpatikorn on 23/11/2569 BE.
//

import UIKit

class AnimeListTableViewController: UITableViewController {

    var era = 1
    private var animeList: [Anime] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Anime.eraTitle(era)
        tableView.rowHeight = 110
        animeList = DBManager.shared.fetchAnime(era: era)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animeList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeCell", for: indexPath) as! AnimeCell
        cell.configure(with: animeList[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetail", sender: animeList[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
           let detailVC = segue.destination as? AnimeDetailViewController,
           let anime = sender as? Anime {
            detailVC.anime = anime
        }
    }
}

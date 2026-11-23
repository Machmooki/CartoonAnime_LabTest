//
//  MainMenuViewController.swift
//  CartoonAnime_LabTest
//
//  Created by Mach Suwanpatikorn on 23/11/2569 BE.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var animationImageView: UIImageView!
    @IBOutlet weak var eraSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.font = AppFont.medium(22)
        welcomeLabel.numberOfLines = 2
        welcomeLabel.adjustsFontSizeToFitWidth = true

        let frames = DBManager.shared.allImageNames().compactMap { UIImage(named: $0) }
        animationImageView.contentMode = .scaleAspectFit
        animationImageView.animationImages = frames
        animationImageView.animationDuration = Double(frames.count) * 0.8
        animationImageView.animationRepeatCount = 0
        animationImageView.image = frames.first

        let normal: [NSAttributedString.Key: Any] = [.font: AppFont.regular(13)]
        eraSegmentedControl.setTitleTextAttributes(normal, for: .normal)
        eraSegmentedControl.setTitle("ก่อน 2000", forSegmentAt: 0)
        eraSegmentedControl.setTitle("2000-2020", forSegmentAt: 1)
        eraSegmentedControl.setTitle("2021", forSegmentAt: 2)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

        let name = UserStore.currentUsername ?? ""
        welcomeLabel.text = "ยินดีต้อนรับคุณ \(name) ที่เข้ามาชมงาน"

        eraSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment

        animationImageView.startAnimating()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        animationImageView.stopAnimating()
    }

    @IBAction func eraChanged(_ sender: UISegmentedControl) {
        guard sender.selectedSegmentIndex != UISegmentedControl.noSegment else { return }
        performSegue(withIdentifier: "showAnimeList", sender: sender.selectedSegmentIndex + 1)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAnimeList",
           let listVC = segue.destination as? AnimeListTableViewController,
           let era = sender as? Int {
            listVC.era = era
        }
    }
}

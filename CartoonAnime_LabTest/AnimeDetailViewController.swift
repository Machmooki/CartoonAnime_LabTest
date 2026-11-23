//
//  AnimeDetailViewController.swift
//  CartoonAnime_LabTest
//
//  Created by Mach Suwanpatikorn on 23/11/2569 BE.
//

import UIKit
import WebKit
import AVKit
import AVFoundation

class AnimeDetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var offlineVideoButton: UIButton!
    @IBOutlet weak var informationButton: UIButton!

    var anime: Anime!

    private let spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = anime.title

        offlineVideoButton.setTitle("Offline Video", for: .normal)
        informationButton.setTitle("Location", for: .normal)

        spinner.color = .white
        spinner.hidesWhenStopped = true
        spinner.center = webView.center
        view.addSubview(spinner)

        webView.navigationDelegate = self
        if let url = URL(string: anime.referenceURL) {
            spinner.startAnimating()
            webView.load(URLRequest(url: url))
        }
    }

    @IBAction func playOfflineVideo(_ sender: Any) {
        let name = (anime.videoName as NSString).deletingPathExtension
        let ext = (anime.videoName as NSString).pathExtension.isEmpty
            ? "mp4" : (anime.videoName as NSString).pathExtension

        guard let url = Bundle.main.url(forResource: name, withExtension: ext)
                ?? Bundle.main.url(forResource: name, withExtension: ext, subdirectory: "Videos") else {
            let alert = UIAlertController(title: "ไม่พบวิดีโอ",
                                          message: "ไม่มีไฟล์ \(anime.videoName) ในแอป",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .default))
            present(alert, animated: true)
            return
        }

        let player = AVPlayer(url: url)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        present(playerVC, animated: true) {
            player.play()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCreatorMap",
           let mapVC = segue.destination as? CreatorMapViewController {
            mapVC.anime = anime
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
    }
}

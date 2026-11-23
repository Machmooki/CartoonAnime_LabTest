//
//  CreatorMapViewController.swift
//  CartoonAnime_LabTest
//
//  Created by Mach Suwanpatikorn on 23/11/2569 BE.
//

import UIKit
import MapKit
import CoreLocation

class CreatorMapViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    var anime: Anime!

    private let swuCoordinate = CLLocationCoordinate2D(latitude: 13.7466, longitude: 100.5666)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ผู้แต่ง / ผู้สร้าง"

        infoLabel.numberOfLines = 0
        infoLabel.font = AppFont.regular(15)
        infoLabel.text = "ผู้แต่ง/ผู้สร้าง: \(anime.creator)\n📍 \(anime.locationName)"

        var coordinate = swuCoordinate
        if let lat = anime.latitude, let lon = anime.longitude {
            coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }

        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = anime.creator
        pin.subtitle = anime.locationAddress ?? anime.locationName
        mapView.addAnnotation(pin)

        let region = MKCoordinateRegion(center: coordinate,
                                        latitudinalMeters: 1500,
                                        longitudinalMeters: 1500)
        mapView.setRegion(region, animated: false)
        mapView.selectAnnotation(pin, animated: true)
    }
}

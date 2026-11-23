//
//  Anime.swift
//  CartoonAnime_LabTest
//
//  Created by Mach Suwanpatikorn on 23/11/2569 BE.
//

import UIKit

struct Anime {
    let id: Int
    let era: Int
    let title: String
    let releaseYear: Int
    let synopsis: String
    let imageName: String
    let videoName: String    
    let creator: String
    let locationName: String
    let locationAddress: String?
    let latitude: Double?
    let longitude: Double?
    let referenceURL: String

    var imageAssetName: String {
        (imageName as NSString).deletingPathExtension
    }

    var posterImage: UIImage? {
        UIImage(named: imageAssetName)
    }

    static func eraTitle(_ era: Int) -> String {
        switch era {
        case 1: return "ก่อนปี 2000"
        case 2: return "ปี 2000 - 2020"
        default: return "ปี 2021"
        }
    }
}

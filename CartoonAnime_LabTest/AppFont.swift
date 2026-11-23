//
//  AppFont.swift
//  CartoonAnime_LabTest
//
//  Created by Mach Suwanpatikorn on 23/11/2569 BE.
//  External font: Penny Lane Corroded Bold (PennyLaneCorrodedBold.ttf, registered in Info.plist UIAppFonts)
//  Latin only: Thai text falls back to the system font automatically.
//

import UIKit

enum AppFont {
    static func regular(_ size: CGFloat) -> UIFont {
        UIFont(name: "PennyLaneCorrodedBold", size: size) ?? .systemFont(ofSize: size)
    }

    static func medium(_ size: CGFloat) -> UIFont {
        UIFont(name: "PennyLaneCorrodedBold", size: size) ?? .boldSystemFont(ofSize: size)
    }
}

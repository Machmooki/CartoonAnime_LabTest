//
//  DBManager.swift
//  CartoonAnime_LabTest
//
//  Created by Mach Suwanpatikorn on 23/11/2569 BE.
//

import Foundation
import SQLite

final class DBManager {

    static let shared = DBManager()

    private var db: Connection?

    private let animeTable      = Table("anime")
    private let colID           = SQLite.Expression<Int64>("id")
    private let colEra          = SQLite.Expression<Int64>("era")
    private let colTitle        = SQLite.Expression<String>("title")
    private let colReleaseYear  = SQLite.Expression<Int64>("release_year")
    private let colSynopsis     = SQLite.Expression<String>("synopsis")
    private let colImageName    = SQLite.Expression<String>("image_name")
    private let colVideoName    = SQLite.Expression<String>("video_name")
    private let colCreator      = SQLite.Expression<String>("creator")
    private let colLocationName = SQLite.Expression<String>("location_name")
    private let colLocationAddr = SQLite.Expression<String?>("location_address")
    private let colLatitude     = SQLite.Expression<Double?>("latitude")
    private let colLongitude    = SQLite.Expression<Double?>("longitude")
    private let colURL          = SQLite.Expression<String>("reference_url")

    private init() {
        openDatabase()
    }

    private func openDatabase() {
        let fm = FileManager.default
        do {
            let docs = try fm.url(for: .documentDirectory, in: .userDomainMask,
                                  appropriateFor: nil, create: true)
            let dbURL = docs.appendingPathComponent("anime.sqlite")

            if !fm.fileExists(atPath: dbURL.path),
               let bundled = Bundle.main.url(forResource: "anime", withExtension: "sqlite") {
                try fm.copyItem(at: bundled, to: dbURL)
            }

            let connection = try Connection(dbURL.path)

            let tableCount = try connection.scalar(
                "SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = 'anime'"
            ) as? Int64 ?? 0
            if tableCount == 0,
               let sqlURL = Bundle.main.url(forResource: "anime", withExtension: "sql") {
                let script = try String(contentsOf: sqlURL, encoding: .utf8)
                try connection.execute(script)
            }

            db = connection
            print("SQLite path: \(dbURL.path)")
        } catch {
            print("เปิดฐานข้อมูลไม่สำเร็จ: \(error)")
        }
    }

    func fetchAnime(era: Int) -> [Anime] {
        guard let db else { return [] }
        let query = animeTable
            .filter(colEra == Int64(era))
            .order(colReleaseYear.asc, colID.asc)
        do {
            return try db.prepare(query).map(makeAnime)
        } catch {
            print("Query error: \(error)")
            return []
        }
    }

    func allImageNames() -> [String] {
        guard let db else { return [] }
        do {
            return try db.prepare(animeTable.select(colImageName).order(colID.asc))
                .map { ($0[colImageName] as NSString).deletingPathExtension }
        } catch {
            print("Query error: \(error)")
            return []
        }
    }

    private func makeAnime(_ row: Row) -> Anime {
        Anime(id: Int(row[colID]),
              era: Int(row[colEra]),
              title: row[colTitle],
              releaseYear: Int(row[colReleaseYear]),
              synopsis: row[colSynopsis],
              imageName: row[colImageName],
              videoName: row[colVideoName],
              creator: row[colCreator],
              locationName: row[colLocationName],
              locationAddress: row[colLocationAddr],
              latitude: row[colLatitude],
              longitude: row[colLongitude],
              referenceURL: row[colURL])
    }
}

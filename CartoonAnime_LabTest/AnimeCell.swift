//
//  AnimeCell.swift
//  CartoonAnime_LabTest
//
//  Created by Mach Suwanpatikorn on 23/11/2569 BE.
//

import UIKit

class AnimeCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 6
        titleLabel.font = AppFont.medium(17)
        yearLabel.font = AppFont.regular(14)
        yearLabel.textColor = .secondaryLabel
    }

    func configure(with anime: Anime) {
        posterImageView.image = anime.posterImage
        titleLabel.text = anime.title
        yearLabel.text = "เริ่มฉายปี \(anime.releaseYear)"
    }
}

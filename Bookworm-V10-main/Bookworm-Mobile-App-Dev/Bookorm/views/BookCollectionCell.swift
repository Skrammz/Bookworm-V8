//
//  BookTableCell.swift
//  Bookorm
//
//  Created by Student Account  on 3/27/23.
//

import UIKit

class BookCollectionCell: UICollectionViewCell {
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    func configure(with book: Book) {
        bookLabel.text = book.volumeInfo.title
        if let thumbnailURLString = book.volumeInfo.imageLinks?.thumbnail,
            let thumbnailURL = URL(string: thumbnailURLString) {
            coverImageView.sd_setImage(with: thumbnailURL)
        } else {
            coverImageView.image = UIImage(named: "defaultThumbnail")
        }
    }
}

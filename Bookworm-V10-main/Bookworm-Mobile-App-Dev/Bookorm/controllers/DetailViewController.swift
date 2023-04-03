//
//  DetailViewController.swift
//  Bookorm
//
//  Created by Student Account  on 3/27/23.
//

import Foundation
import UIKit
import SDWebImage
<<<<<<< HEAD:Bookworm-V10-main/Bookworm-Mobile-App-Dev/Bookorm/controllers/DetailViewController.swift
import SDWebImageSwiftUI

=======
>>>>>>> 68958a5262afbfa92b22f5fb72a1b7d318fee6ed:Bookworm-Mobile-App-Dev/Bookorm/controllers/DetailViewController.swift
class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var inListLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
<<<<<<< HEAD:Bookworm-V10-main/Bookworm-Mobile-App-Dev/Bookorm/controllers/DetailViewController.swift
    }
=======
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book {
            configure(with: book)
        }
    }
    
    func configure(with book: Books) {
        titleLabel.text = book.title
        authorLabel.text = book.authors
        
        if let thumbnailURLString = book.thumbnailUrl,
           let thumbnailURL = URL(string: thumbnailURLString) {
            thumbnailImageView.sd_setImage(with: thumbnailURL)
        } else {
            thumbnailImageView.image = UIImage(named: "defaultThumbnail")
        }
    }
}

>>>>>>> 68958a5262afbfa92b22f5fb72a1b7d318fee6ed:Bookworm-Mobile-App-Dev/Bookorm/controllers/DetailViewController.swift

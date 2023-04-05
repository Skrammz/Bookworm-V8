//
//  DetailViewController.swift
//  Bookorm
//
//  Created by Student Account  on 3/27/23.
//

import Foundation
import UIKit


class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var inListLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var addRating: UIButton!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var notYetRatedLabel: UILabel!
    var rating: Int = 0
    var book: Book? {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        guard let book = book, isViewLoaded else { return }
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        inListLabel.text = "Not in any list" // Update this according to your app's logic
        summaryTextView.text = book.description
        if let thumbnailURL = book.thumbnailURL {
            URLSession.shared.dataTask(with: thumbnailURL) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }.resume()
        } else {
            thumbnailImageView.image = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dispRatingStars(rating: rating)
        updateUI()
    }
    
    func dispRatingStars(rating: Int){
        if (rating == 1) {
            self.notYetRatedLabel.isHidden = true
            self.star1.isHidden = false
            self.star2.isHidden = true
            self.star3.isHidden = true
            self.star4.isHidden = true
            self.star5.isHidden = true
        } else if (rating == 2) {
            self.notYetRatedLabel.isHidden = true
            self.star1.isHidden = false
            self.star2.isHidden = false
            self.star3.isHidden = true
            self.star4.isHidden = true
            self.star5.isHidden = true
        } else if (rating == 3){
            self.notYetRatedLabel.isHidden = true
            self.star1.isHidden = false
            self.star2.isHidden = false
            self.star3.isHidden = false
            self.star4.isHidden = true
            self.star5.isHidden = true
        } else if (rating == 4){
            self.notYetRatedLabel.isHidden = true
            self.star1.isHidden = false
            self.star2.isHidden = false
            self.star3.isHidden = false
            self.star4.isHidden = false
            self.star5.isHidden = true
        } else if (rating == 5){
            self.notYetRatedLabel.isHidden = true
            self.star1.isHidden = false
            self.star2.isHidden = false
            self.star3.isHidden = false
            self.star4.isHidden = false
            self.star5.isHidden = false
        }else {
            self.notYetRatedLabel.isHidden = false
            self.star1.isHidden = true
            self.star2.isHidden = true
            self.star3.isHidden = true
            self.star4.isHidden = true
            self.star5.isHidden = true
        }
    }
    
    @IBAction func onAddRating(_ sender: UIButton) {
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (action) in
        }
        let rate1 = UIAlertAction(title: "1",
                                         style: .default) { (action) in
            self.rating = 1
            self.dispRatingStars(rating: self.rating)
        }
        let rate2 = UIAlertAction(title: "2",
                                         style: .default) { (action) in
            self.rating = 2
            self.dispRatingStars(rating: self.rating)
        }
        let rate3 = UIAlertAction(title: "3",
                                         style: .default) { (action) in
            self.rating = 3
            self.dispRatingStars(rating: self.rating)
        }
        let rate4 = UIAlertAction(title: "4",
                                         style: .default) { (action) in
            self.rating = 4
            self.dispRatingStars(rating: self.rating)
        }
        let rate5 = UIAlertAction(title: "5",
                                         style: .default) { (action) in
            self.rating = 5
            self.dispRatingStars(rating: self.rating)
        }
        let alert = UIAlertController(title: "Add Rating",
                                      message: "Please Rate The Book.",
                                      preferredStyle: .alert)
        
        alert.addAction(cancelAction)
        alert.addAction(rate1)
        alert.addAction(rate2)
        alert.addAction(rate3)
        alert.addAction(rate4)
        alert.addAction(rate5)
        self.present(alert, animated: true) {
        }
    }
}

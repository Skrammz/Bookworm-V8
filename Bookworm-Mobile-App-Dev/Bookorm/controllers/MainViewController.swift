//
//  ViewController.swift
//  Bookorm
//
//  Created by Student Account  on 3/10/23.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!

    var books: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the table view's data source to self
        tableView.dataSource = self
        // Call the searchBooks function with a query to load initial data
        searchBooks(for: "swift programming")
    }

    func searchBooks(for query: String) {
        BooksAPI.shared.searchBooks(for: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    self.books = books
                    self.tableView.reloadData()
                case .failure(let error):
                    // Display an error message to the user
                    print(error.localizedDescription)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    //Connected in Book Table Cell and Detail View Controller
    class BookCell: UITableViewCell {
        
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var authorLabel: UILabel!
        @IBOutlet weak var descriptionLabel: UILabel!
        @IBOutlet weak var thumbnailImageView: UIImageView!
        
        override func awakeFromNib() {
            super.awakeFromNib()
        }
    }

    //Should this be moved??
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        let book = books[indexPath.row]
        cell.titleLabel.text = book.volumeInfo.title
        cell.authorLabel.text = book.volumeInfo.authors?.joined(separator: ", ")
        cell.descriptionLabel.text = book.volumeInfo.description
        if let thumbnailURLString = book.volumeInfo.imageLinks?.thumbnail,
           let thumbnailURL = URL(string: thumbnailURLString) {
            cell.thumbnailImageView.sd_setImage(with: thumbnailURL)
        } else {
            cell.thumbnailImageView.image = UIImage(named: "defaultThumbnail")
        }
        return cell
    }

}

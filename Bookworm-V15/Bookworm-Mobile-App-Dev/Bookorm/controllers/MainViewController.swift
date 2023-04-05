//
//  ViewController.swift
//  Bookorm
//
//  Created by Student Account  on 3/10/23.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let googleBooksAPI = GoogleBooksAPI()
        
        var books: [Book] = []
        
        // Add your data for the table view here
        var tableData: [String] = []
        
        func searchBooks(query: String) {
            googleBooksAPI.searchBooks(query: query) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedBooks):
                        self?.books = fetchedBooks
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                        self?.books = []
                    }
                    self?.collectionView.reloadData()
                }
            }
        }
        
        // UITableView methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tableData.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourCellIdentifier", for: indexPath)
            cell.textLabel?.text = tableData[indexPath.row]
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionCell", for: indexPath) as! BookCollectionCell
        let book = books[indexPath.item]
        cell.bookLabel.text = book.title

        if let thumbnailURL = book.thumbnailURL {
            print("Thumbnail URL: \(thumbnailURL)") // Add this print statement

            // Load the image asynchronously
            URLSession.shared.dataTask(with: thumbnailURL) { data, _, error in
                if let error = error {
                    print("Error loading image: \(error)") // Add this print statement
                    return
                }

                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    cell.coverImageView.image = image
                }
            }.resume()
        } else {
            print("No thumbnail URL for book: \(book.title)") // Add this print statement
            cell.coverImageView.image = nil
        }

        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.item]
        performSegue(withIdentifier: "ShowBookDetails", sender: selectedBook)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBookDetails",
           let detailViewController = segue.destination as? DetailViewController,
           let selectedBook = sender as? Book {
            detailViewController.book = selectedBook
        }
    }
}

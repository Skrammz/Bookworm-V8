//
//  ViewController.swift
//  Bookorm
//
//  Created by Student Account  on 3/10/23.
//

import UIKit
<<<<<<< HEAD:Bookworm-V10-main/Bookworm-Mobile-App-Dev/Bookorm/controllers/MainViewController.swift
import SDWebImage

class MainViewController: UIViewController, UITableViewDataSource, UICollectionViewDataSource {
=======
import CoreData
import Alamofire
import AlamofireImage
>>>>>>> 68958a5262afbfa92b22f5fb72a1b7d318fee6ed:Bookworm-Mobile-App-Dev/Bookorm/controllers/MainViewController.swift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
<<<<<<< HEAD:Bookworm-V10-main/Bookworm-Mobile-App-Dev/Bookorm/controllers/MainViewController.swift
    @IBOutlet weak var collectionView: UICollectionView!

    var books: [Book] = []
    //var lists: []

=======
    var books: [Books] = []
    
>>>>>>> 68958a5262afbfa92b22f5fb72a1b7d318fee6ed:Bookworm-Mobile-App-Dev/Bookorm/controllers/MainViewController.swift
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
<<<<<<< HEAD:Bookworm-V10-main/Bookworm-Mobile-App-Dev/Bookorm/controllers/MainViewController.swift
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // list count instead
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cells should be lists
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableCell
        // change to lists
        let book = books[indexPath.row]
        // needs different configure function in ListTableCell
        cell.configure(with: book)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCollectionCell
        let book = books[indexPath.item]
        cell.configure(with: book)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectColumnAt indexPath: IndexPath){
        // go to detail view
        performSegue(withIdentifier: "GoToDetail", sender: self)
=======
        tableView.delegate = self
        
        //clearStorage()
        loadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookTableViewCell
        
        cell.titleLabel.text = books[indexPath.row].title
        //cell.authorsLabel.text = books[indexPath.row].authors
        
        if let thumbnailUrlString = books[indexPath.row].thumbnailUrl as String? {
            if let thumbnailUrl = URL(string: thumbnailUrlString) {
                AF.request(thumbnailUrl).responseImage(completionHandler: { response in
                    if case .success(let image) = response.result {
                        cell.thumbnailImageView.image = image
                    }
                })
            }
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func clearStorage() {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        books.forEach { item in
            managedContext.delete(item)
        }
        do { try managedContext.save() } catch {}
    }
    
    func loadData() {
        let defaults = UserDefaults.standard
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if defaults.bool(forKey: "isDownloaded") {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
            do {
                let dbItems = try managedContext.fetch(fetchRequest) as! [Bookorm.Books]
                books.append(contentsOf: dbItems)
                tableView.reloadData()
            } catch {}
        } else {
            let query = "swift" // Set your search query
            let googleBooksAPI = "https://www.googleapis.com/books/v1/volumes?q=\(query)&maxResults=20"
            AF.request(googleBooksAPI).responseDecodable(of: ApiBooksContainer.self, completionHandler: { response in
                do {
                    try response.value?.items.forEach { item in
                        let myObject = NSEntityDescription.insertNewObject(forEntityName: "Books", into: managedContext) as! Bookorm.Books
                        myObject.title = item.volumeInfo.title
                        myObject.authors = item.volumeInfo.authors.joined(separator: ", ")
                        myObject.thumbnailUrl = item.volumeInfo.imageLinks?.thumbnail
                        
                        try managedContext.save()
                        
                        self.books.append(myObject)
                    }
                    self.tableView.reloadData()
                    defaults.set(true, forKey: "isDownloaded")
                } catch {}
            })
        }
>>>>>>> 68958a5262afbfa92b22f5fb72a1b7d318fee6ed:Bookworm-Mobile-App-Dev/Bookorm/controllers/MainViewController.swift
    }
}

//
//  ProfileViewController.swift
//  Bookorm
//
//  Created by Student Account  on 3/27/23.
//

import Foundation
import UIKit


class ProfileViewController: UIViewController, UICollectionViewDelegate, UITableViewDelegate{
    @IBOutlet var booksReadLabel: UILabel!
    @IBOutlet var pagesReadLabel: UILabel!
    @IBOutlet var booksRatedLabel: UILabel!
    @IBOutlet var addListButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
}

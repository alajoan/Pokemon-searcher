//
//  FavoriteTypeDetailViewController.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 10/05/21.
//

import UIKit

class FavoriteTypeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    var types: [PoketypesResult] = []
    var selectedItem: PoketypesResult?
    
    // MARK: - IBOutlets
    @IBOutlet weak var favoriteTypeTableView: UITableView!
    
    // MARK: - View related
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        favoriteTypeTableView.delegate = self
        favoriteTypeTableView.dataSource = self
        
        DataFetcher.fetchPoketypes { (type) in
            self.types = type
        }
    }
    
    // MARK: - Tableview Related
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = favoriteTypeTableView.cellForRow(at: indexPath) as! FavoriteTypeTableViewCell
        cell.cellSelected = true
        cell.typeSelected.image
            = UIImage(named: "radio-on")
        selectedItem = types[indexPath.row]
        cell.reloadInputViews()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = types[indexPath.row]
            
            let cell = favoriteTypeTableView.dequeueReusableCell(withIdentifier: "typeCell") as! FavoriteTypeTableViewCell
        cell.prepareForReuse()
            cell.setCell(type: type)
        
            cell.reloadInputViews()
            return cell
       
    }
    
    // MARK: -IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        let defaultUser = UserDefaults.standard
        defaultUser.set(selectedItem?.name, forKey: "favoriteTypeName")
        defaultUser.set(selectedItem?.thumbnailImage, forKey: "favoriteTypeThumbnail")
        performSegue(withIdentifier: "returnFromFavoriteType", sender: self)
        
    }
    
    
}

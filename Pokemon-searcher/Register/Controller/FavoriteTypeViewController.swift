//
//  FavoriteTypeViewController.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 10/05/21.
//

import UIKit

class FavoriteTypeViewController: UIViewController{
    
    // MARK: - IBOutlets
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var trainerName: UILabel!
    @IBOutlet weak var typeSearchButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "chooseFavoriteType", sender: self)
    }
    
    @IBAction func goToMain(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isRegistered")
        self.present(UIStoryboard.buildMainViewController(), animated: true, completion: nil)
        
    }
    
    
    // MARK: - View related
    func loadDefaults() {
        let defaults = UserDefaults.standard
        let name = defaults.object(forKey: "name") as? String ?? String()
        trainerName.text = "Hello, Trainer \(name)!"
        let typeName = defaults.object(forKey: "favoriteTypeName") as? String
        let typeThumbnail = defaults.object(forKey: "favoriteTypeThumbnail") as? String
        
        if(typeName != nil && typeThumbnail != nil) {
            DataFetcher.fetchImage(URL: typeThumbnail ?? "") { (image) in
                self.typeImage.image = image
            }
            
            typeLabel.text = "\(typeName?.capitalizingFirstLetter() ?? "No type huh?")!, nice choice!"
        } else {
            
            typeLabel.text = ""
            typeImage.image = nil
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
        
    }
    
    
    
}

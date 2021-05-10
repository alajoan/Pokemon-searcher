//
//  FavoriteTypeTableViewCell.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 10/05/21.
//

import UIKit

class FavoriteTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var typeName: UILabel!
    @IBOutlet weak var typeSelected: UIImageView!
    
    public var cellSelected: Bool = false
    
    override func prepareForReuse() {
             super.prepareForReuse()
       
        typeSelected.image = UIImage(named: "radio-off")
        typeImage.image = nil
        typeName.text = nil
        cellSelected = false
        }

    func setCell(type: PoketypesResult) {
        
        DataFetcher.fetchImage(URL: type.thumbnailImage) { (typeImage) in
            self.typeImage.image = typeImage
        }
        
        typeName.text = type.name
        // FIXME: cleaning
        if(cellSelected == true) {
            typeImage.image = UIImage(named: "radio-on")
        } else {
            typeImage.image = UIImage(named: "radio-off")
        }
        
       
    }

}

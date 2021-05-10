//
//  MainCollectionViewCell.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 08/05/21.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var typeName: UILabel!
    func setCell(type: PoketypesResult) {
        
        DataFetcher.fetchImage(URL: type.thumbnailImage) { (typeImage) in
            self.typeImage.image = typeImage
        }
        
        typeName.text = type.name
    }
}

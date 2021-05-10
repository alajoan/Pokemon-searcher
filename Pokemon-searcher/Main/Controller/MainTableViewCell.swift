//
//  MainTableViewCell.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 08/05/21.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonId: UILabel!
    
    override func prepareForReuse() {
             super.prepareForReuse()
        cellImage.image = nil
        pokemonName.text = nil
        pokemonId.text = nil
        }
    
    func setCell(pokemon: Pokedata) {
        
        DataFetcher.fetchImage(URL: pokemon.thumbnailImage ) { (pokeImage) in
            self.cellImage.image = pokeImage
        }
        
        pokemonName.text = pokemon.name
        pokemonId.text = "Nº \(pokemon.number )"
        
    }
    

}

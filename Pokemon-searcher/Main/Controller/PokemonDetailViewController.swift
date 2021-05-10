//
//  PokemonDetailViewController.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 09/05/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - Variables
    var data: Pokedata?

    // MARK: -IBOutlets
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonAbilities: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var pokemonHeight: UILabel!
    @IBOutlet weak var pokemonWeaknesses: UILabel!
    @IBOutlet weak var circleImage: UIImageView!
    
    // MARK: - Views related
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pokemonName.text = data?.name ?? "N/A"
        pokemonNumber.text = "Nº \(data?.number ?? "N/A")"
        
        if let unwrapAbilities = data?.abilities {
            pokemonAbilities.text = "Abilities\n\(unwrapAbilities.joined(separator: ", "))"
        }
        if let unwrapType = data?.type {
            pokemonType.text = "Type\n\(unwrapType.joined(separator: ", "))"
        }
        if let unwrapWeakness = data?.weakness {
            pokemonWeaknesses.text = "Weaknesses\n\(unwrapWeakness.joined(separator: ", "))"
        }
        if let unwrapWeight = data?.weight {
            pokemonWeight.text = "Weight\n\(unwrapWeight)"
        }
        if let unwrapHeight = data?.height {
            pokemonHeight.text = "Height\n\(unwrapHeight)"
        }
        
        DataFetcher.fetchImage(URL: data?.thumbnailImage ?? "") { (Image) in
            self.pokemonImage.image = Image
        }
        circleImage.makeRounded()
    }

}

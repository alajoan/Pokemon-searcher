//
//  MainViewController.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 08/05/21.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var textfieldSearch: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableviewMain: UITableView!
    @IBOutlet weak var collectionViewMain: UICollectionView!
    
    // MARK: - Variables
    var types: [PoketypesResult] = [] //Types of pokemons
    var pokemons: [Pokedata] = [] //Original list containing all pokemons
    var pokemonsModified: [Pokedata] = [] //List that is actually used in table view because of filters
    var selectedItem: Pokedata? //Pokemondata that will be sent in a segue for details
    
    // MARK: - Collection View related
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = types[indexPath.item]
        
        let cell = collectionViewMain.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! MainCollectionViewCell
        
        cell.setCell(type: type)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        pokemonsModified = pokemons
        
        //Filter to return pokemons by type
        let pokemonFilteredByType = pokemons.filter{ $0.type.contains(types[indexPath.item].name ?? "") }
        
        print(types[indexPath.item])
        pokemonsModified = pokemonFilteredByType
        reloadInputViews()
        tableviewMain.reloadData()
    }
    
    // MARK: - TableView Related
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemonsModified.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemon = pokemonsModified[indexPath.row]
        
        let cell = tableviewMain.dequeueReusableCell(withIdentifier: "pokemonCell") as! MainTableViewCell
        
        
        cell.setCell(pokemon: pokemon)
        cell.reloadInputViews()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = pokemonsModified[indexPath.row]
        performSegue(withIdentifier: "pokemonDetailSegue", sender: self)
    }
    
    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetailSegue" {
            if let destinationVc = segue.destination as? PokemonDetailViewController {
                destinationVc.data = selectedItem
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func searchPressed(_ sender: UIButton) {
        print("Button working")
        textfieldSearch.endEditing(true)
    }
    
    //This function is activated by a invisible button on the main storyboard for reseting the registering process
    @IBAction func resetRegister(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isRegistered")
        defaults.set(nil, forKey: "favoriteTypeName")
        defaults.set(nil, forKey: "favoriteTypeThumbnail")
        print("Resetado")
    }
    
    // MARK: - Textfield related
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Filtering by name
        let pokemonFilteredByName = pokemons.filter{$0.name.contains(textfieldSearch.text!.capitalizingFirstLetter())}
        pokemonsModified = pokemonFilteredByName
        print("Pokemon: \(pokemonsModified)")
        tableviewMain.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text != "") {
            return true
        } else {
            textField.placeholder = "Enter something to search"
            return false
        }
    }
    
    // MARK: - Views Related
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfieldSearch.delegate = self
        tableviewMain.delegate = self
        tableviewMain.dataSource = self
        
        collectionViewMain.delegate = self
        collectionViewMain.dataSource = self
        
        pokemons.removeAll()
        types.removeAll()
        
        DataFetcher.fetchPokemon { (pokemon) in
            self.pokemons = pokemon
            self.pokemonsModified = pokemon
        }
        
        DataFetcher.fetchPoketypes { (poketype) in
            self.types = poketype
            self.collectionViewMain.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard
        let type = defaults.object(forKey: "favoriteTypeName") as? String
        
        let isRegistered = defaults.object(forKey: "isRegistered") as? Bool
        
        //If the user was not registered, go to the main scene for registering
        if(isRegistered==false || isRegistered == nil) {
            self.present(UIStoryboard.buildRegisterViewController(), animated: true, completion: nil)
        }
        
        let pokemonFilteredByType = pokemons.filter{ $0.type.contains(type ?? "") }
        pokemonsModified = pokemonFilteredByType
        reloadInputViews()
        tableviewMain.reloadData()
        
    }
}

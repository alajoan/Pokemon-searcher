//
//  DataFetcher.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 08/05/21.
//


import Foundation
import Alamofire

//This class holds all the functions needed to fetch JSON files or Images from a URL
class DataFetcher {
    
    //This function fetches the pokemon in a JSON in order to use it on the main tableView
    static func fetchPokemon(completionHandler: @escaping([Pokedata]) -> Void){
        
        let path = Bundle.main.path(forResource: "pokemons", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            let pokemon = try JSONDecoder().decode([Pokedata].self, from: data)
            let listArray = pokemon.unique{$0.number} //This filter searches for duplicates and is located in utils extensions
            completionHandler(listArray)
        }
        catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
    }
    
    //this function searches for the types of pokemons in a json
    static func fetchPoketypes(completionHandler: @escaping([PoketypesResult]) -> Void){
        
        let path = Bundle.main.path(forResource: "types", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            let pokemon = try JSONDecoder().decode(PoketypesRoot.self, from: data)
            completionHandler(pokemon.results)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        
    }
    
    //This function fetches images from a given URL
    static func fetchImage(URL: String, completionHandler: @escaping(UIImage) -> Void) {
        
        var tempImage: UIImage = UIImage()
        
        _ = AF.request(URL, method: .get).response{ (response) in
            switch response.result {
            case .success(let responseData):
                tempImage = UIImage(data: responseData!, scale: 1) ?? tempImage
                completionHandler(tempImage)
                break
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
}

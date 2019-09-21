//
//  Services.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/3/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class Services {
    static let shared = Services(); private init() {
        //constructor por defecto
    }
    func getPokemons() -> [PokemonResponse]? {
        var pokemons: [PokemonResponse]? = []
        Alamofire.request("https://pokeapi.co/api/v2/pokemon?&limit=964").responseJSON { response in
            let swiftyJsonVar = JSON(response.result.value as! Dictionary<String, AnyObject>)
            pokemons = [PokemonResponse]()
            if let pokemon = swiftyJsonVar["results"].arrayObject as? [[String : AnyObject]]{
                for results in pokemon {
                    let newPokemon = PokemonResponse()
                    if  let name = results["name"] as? String {
                        newPokemon.name = name
                    }
                    pokemons?.append(newPokemon)
                }
            }else{
                print("Error in fetching the NEWS JSON")
            }
        }
        return pokemons
    }
    
    func getRegions(success: @escaping ([Result1]?) -> Void, fail: @escaping (String) -> Void) {
        var regions: [Result1]? = []
        Alamofire.request("https://pokeapi.co/api/v2/region").responseJSON { response in
            switch response.result {
            case .success :
                let swiftyJsonVar = JSON(response.result.value as! Dictionary<String, AnyObject>)
                regions = [Result1]()
                if let pokemon = swiftyJsonVar["results"].arrayObject as? [[String : AnyObject]]{
                    for results in pokemon {
                        let newRegion = Result1()
                        if let name = results["name"] as? String {
                            newRegion.name = name
                        }
                        if let url = results["url"] as? String {
                            newRegion.url = url
                        }
                        regions?.append(newRegion)
                    }
                } else {
                    print("Error in fetching the NEWS JSON")
                }
                success(regions)
            case .failure(let error) :
                fail(error.localizedDescription)
            }
        }
    }
    
    func getPokemonsPerRegion(url: String, success: @escaping (Dictionary<String, String>) -> Void, fail: @escaping (String) -> Void) {
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success :
                let swiftyJsonVar = JSON(response.result.value as! Dictionary<String, AnyObject>)
                //regions = [Result1]()
                var urlPokedex: String = ""
                if let pokemon = swiftyJsonVar["pokedexes"].arrayObject as? [[String : AnyObject]]{
                    for results in pokemon {
                        if let url = results["url"] as? String {
                            urlPokedex = url
                        }
                    }
                    self.getPokedex(url: urlPokedex, success: {(result) in
                        success(result)
                    })
                }
            case .failure(let error) :
                fail(error.localizedDescription)
            }
        }
    }
    
    private func getPokedex(url: String, success: @escaping (Dictionary<String, String>) -> Void) {
        var result = Dictionary<String, String>()
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success :
                let data = response.data
                var urlPokedex: [String] = []
                var urlNames: [String] = []
                do {
                    let entries = try JSONDecoder().decode(PokemonResponse.self, from: data!)
                    for item in entries.pokemon_entries! {
                        if let url = item.pokemon_species?.url{
                            let urlReplaced = url.replacingOccurrences(of: "pokemon-species", with: "pokemon")
                            let newUrl = urlReplaced.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon",
                                                                          with: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon")
                            
                            let urlImage = "\(newUrl.dropLast()).png"
                            urlPokedex.append(urlImage)
                        }
                        if let name = item.pokemon_species?.name {
                            urlNames.append(name)
                        }
                    }
                } catch let err {
                    print(err.localizedDescription)
                }
                var i = 0
                for item in urlPokedex {
                    result.append(item, key: urlNames[i])
                    i += 1
                }
                success(result)
            case .failure(let error) :
                //fail(error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
}

extension Dictionary where Key == String, Value == String {
    mutating func append(_ string:String, key:String) {
        if var value = self[key] {
            // if an array exist, append to it
            value.append(string)
            self[key] = value
        } else {
            // create a new array since there is nothing here
            self[key] = string
        }
    }
}

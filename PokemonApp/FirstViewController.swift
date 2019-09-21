//
//  FirstViewController.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/3/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    var presenter = RegionPresenter()
    var createTeamPresenter = CreateTeamPresenter()
    var lstRegions: [Result1]? = []
    var pokemons: [PokemonModel] = []
    @IBOutlet weak var imgPrincipal: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        presenter.getRegions()
        createTeamPresenter.attachView(view: self)
        imgPrincipal.image = UIImage(named: "pokemon_icon")
    }
    @IBOutlet weak var tableView: UITableView!
    
    static func instantiate() -> FirstViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstViewController") as! FirstViewController
    }

    
}
extension FirstViewController: CreateTeamView {
    func getPokemonByRegion(_ pokemonsRegion: Dictionary<String, String>) {
        for (key, value) in pokemonsRegion {
            let pokemon: PokemonModel = PokemonModel()
            pokemon.name = key
            pokemon.url = value
            pokemons.append(pokemon)
        }
        
        let createTeamController = CreateTeamViewController.instantiate()
        createTeamController.url = ""
        createTeamController.pokemons = pokemons
        self.present(createTeamController, animated: true, completion: nil)
    }
}
extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    //Action for every selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        createTeamPresenter.getPokemonByRegion(url: lstRegions?[indexPath.row].url ?? "")
    }
    //Number of row in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstRegions?.count ?? 0 > 0 ? lstRegions?.count ?? 0 : 0
    }
    //Content per cell in a tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath) as? RegionsCellView
        let region = lstRegions?[indexPath.row]
        cell?.imgRegion?.image = UIImage(named: "map")
        cell?.lblRegion?.text = region?.name
        cell?.selectionStyle = .none
        return cell!
    }
    //Set the heidht for every row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }
}
//Extension for presenter
extension FirstViewController: RegionView {
    func getRegions(_ region: [Result1]?) {
        lstRegions = region
        tableView.reloadData()
    }
}

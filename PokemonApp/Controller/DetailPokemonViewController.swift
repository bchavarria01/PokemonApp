//
//  DetailPokemonViewController.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/10/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Foundation
import UIKit

class DetailPokemonViewController: BaseViewController {
    weak var delegate: SelectPokemonDelegate?
    var secciones: [[CeldaPersonalizada]?] = []
    var presenter = CreateTeamPresenter()
    var pokemons: [PokemonModel] = []
    var url: String = ""
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //0
        let teamData = CeldaPersonalizada(nombre: "DetailPokemonCellView", alto: 220,
                                          celda: DetailPokemonCellView.self,
                                          nibName: "")
        let seccionTeamData = [teamData]
        secciones.append(seccionTeamData)
        
    }
    
    static func instantiate() -> DetailPokemonViewController {
        // swiftlint:disable force_cast
        return UIStoryboard(name: "Main",
                            bundle: nil)
            .instantiateViewController(withIdentifier:
                "detailPokemonViewController") as! DetailPokemonViewController
    }
    
}

extension DetailPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return secciones.count
    }
    //Set heigth for every row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return secciones[indexPath.section]?[indexPath.row].alto ?? 0.0
    }
    //Action for every selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //Number of row in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //Content per cell in a tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellCustom = secciones[indexPath.section]?[indexPath.row]
        guard  let cell =
            tableView.dequeueReusableCell(withIdentifier: cellCustom?.nombre ?? "")
                as?  BaseCeldaCellView else {
                    return UITableViewCell()
        }
        switch cell {
        case is DetailPokemonCellView:
            guard  let detailCell  = cell as? DetailPokemonCellView  else {
                return UITableViewCell()
            }
            
        default:
            break
        }
        cell.selectionStyle = .none
        return cell
    }
}

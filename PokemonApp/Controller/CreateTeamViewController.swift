//
//  CreateTeamViewController.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/5/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit
import FittedSheets

class CreateTeamViewController: BaseViewController {
    weak var delegate: SelectPokemonDelegate?
    var secciones: [[CeldaPersonalizada]?] = []
    var presenter = CreateTeamPresenter()
    var pokemons: [PokemonModel] = []
    var url: String = ""
    @IBOutlet var collection: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sizesTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //0
        let teamData = CeldaPersonalizada(nombre: "teamDataCell", alto: 53,
                                                          celda: TeamDataCellView.self,
                                                          nibName: "")
        let seccionTeamData = [teamData]
        secciones.append(seccionTeamData)
        //1
        let collectionViewCell = CeldaPersonalizada(nombre: "CollectionViewCell", alto: 329,
                                          celda: CollectionViewCell.self,
                                          nibName: "")
        let seccionCollectionView = [collectionViewCell]
        secciones.append(seccionCollectionView)
    }
    
    static func instantiate() -> CreateTeamViewController {
        // swiftlint:disable force_cast
        return UIStoryboard(name: "Main",
                            bundle: nil)
            .instantiateViewController(withIdentifier:
                "CreateTeamView") as! CreateTeamViewController
    }
    
}

extension CreateTeamViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let stringSizes = self.sizesTextField.text!.components(separatedBy: ",")
        var sizes: [SheetSize] = []
        sizes.append(.halfScreen)
        let sheetController = SheetViewController(controller: DetailPokemonViewController.instantiate(), sizes: [.fixed(260)])
        // Adjust how the bottom safe area is handled on iPhone X screens
        sheetController.blurBottomSafeArea = false
        sheetController.adjustForBottomSafeArea = true
        
        // Turn off rounded corners
        sheetController.topCornersRadius = 0
        
        // Make corners more round
        sheetController.topCornersRadius = 15
        
        // Extend the background behind the pull bar instead of having it transparent
        sheetController.extendBackgroundBehindHandle = true
        self.present(sheetController, animated: false, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count > 0 ? pokemons.count : 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCellView", for: indexPath) as? PokemonCellView{
            let pokemon = pokemons[indexPath.row]
            let name = pokemon.name ?? "Pokemon team name"
            let url = URL(string: pokemon.url ?? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/152.png")
            cell.nameLabel.text = name
            cell.thumbImage.load(url: url!)
            return cell
        }
        else { return UICollectionViewCell() }
    }
}

extension CreateTeamViewController: UITableViewDelegate, UITableViewDataSource {
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
        case is TeamDataCellView:
            guard  let dataCell  = cell as? TeamDataCellView  else {
                return UITableViewCell()
            }
            dataCell.textField?.placeholder = "Pokemon team name"
        case is CollectionViewCell:
            guard  cell is CollectionViewCell  else {
                return UITableViewCell()
            }
        default:
            break
        }
        cell.selectionStyle = .none
        return cell
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

protocol SelectPokemonDelegate: class {
    func selectPokemon(pokemonId: String)
}

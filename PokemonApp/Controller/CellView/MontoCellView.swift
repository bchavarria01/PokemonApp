//
//  MontoCellView.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/6/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class MontoCellView: BaseCeldaCellView, UITextFieldDelegate {
    
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet var buttonsContainer: UIView!
    weak var delegate: MontoDelegate?
    @IBOutlet weak var actionImg: UIImageView!
    @IBOutlet weak var imgCheck: UIImageView!
    weak var table: UITableView!
    weak var delegateTable: UITableViewDelegate!
    var lastField = false
    @IBOutlet var decore: SimpleView?
    @IBOutlet var monto: SkyFloatingLabelTextField!
    var showButtons: Bool? {
        didSet {
            if  !self.showButtons!,
                let buttons = buttonsContainer {
                buttons.isHidden = true
            }
        }
    }
    var showDecore: Bool = false {
        didSet {
            self.decore?.isHidden = !self.showDecore
        }
    }
    var placeholder: String? {
        didSet {
            monto.placeholder = self.placeholder
        }
    }
    override var nibName: String? {
        return MontoCellView.identifier
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return "MontoCellView"
    }
    var value: String? {
        return monto.text
    }
    static var identifierSimple: String {
        return "MontoSimpleCellView"
    }
    static var identifierLeftSimple: String {
        return "MontoLeftSimple"
    }
    
    var titulo: String = ""{
        didSet {
            lblTitulo.text = titulo
        }
    }
    var showAction: Bool = false {
        didSet {
            
            actionImg.isHidden = !showAction
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let tmonto =  textField.text?.replacingOccurrences(of: ",", with: ".")
        if tmonto?.hasSuffix(".") ?? false {
            monto.text = monto.text?.replacingOccurrences(of: ",", with: ".") ?? ""  + "0"
        }
        asignarValor(monto: monto.text)
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        selectTableRow()
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        let sstring = string.replacingOccurrences(of: ",", with: ".")
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: sstring)
        let entero =  replacementText.split(separator: ".")
        if !entero.isEmpty && entero[0].count > 6 {
            return false
        }
        
        return replacementText.isEmpty
    }
    
    func asignarValor(monto: String?) {
        if let delegado = delegate {
            delegado.asignarMonto(monto: monto)
        }
    }
    func selectTableRow() {
        if let tableView = table, let delegaTable = delegateTable ,
            let indexPath = table.indexPath(for: self) {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            delegaTable.tableView!(table, didSelectRowAt: indexPath)
        }
    }
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        var  smonto =  monto.text?.trimmingCharacters(in: .whitespacesAndNewlines )
        smonto =  smonto?.replacingOccurrences(of: ",", with: ".")
        if smonto?.hasPrefix(".") ?? false {
            smonto = "\(0)\(smonto ?? "")"
        }
        smonto = smonto?.uppercased().replacingOccurrences(of: "E", with: "")
        monto.text = smonto
        if monto.text!.count > 0 {
            imgCheck!.isHidden = false
        } else {imgCheck!.isHidden = true}
        asignarValor(monto: smonto)
    }
    
    @IBAction func selectMonto(_ sender: Any) {
        if sender is UIButton {
            let button = sender as? UIButton
            monto.text = "\(button?.tag ?? 0)"
            if monto.text!.count > 0 {
                imgCheck!.isHidden = false
            } else {imgCheck!.isHidden = true}
            asignarValor(monto: monto.text)
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if lastField {
            monto.resignFirstResponder()
        }
        return true
    }
}
protocol MontoDelegate: class {
    func asignarMonto(monto: String?)
}


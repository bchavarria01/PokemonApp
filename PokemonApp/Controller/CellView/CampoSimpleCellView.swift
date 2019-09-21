//
//  CampoSimpleCellView.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/6/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Foundation
import UIKit
import ContactsUI
import FittedSheets
// celda para los atributos de pago de servicio
class CampoSimpleCellView: BaseCeldaCellView, UITextFieldDelegate, CNContactPickerDelegate, KeyboardToolbarDelegate {
    func keyboardToolbar(button: UIBarButtonItem, type: KeyboardToolbarButton, tappedIn toolbar: KeyboardToolbar) {
        if type == .siguiente || type == .atras {
            let indiceCampo = type == .siguiente ?
                (atributo?.tag ?? 0) + 1  :   (atributo?.tag ?? 0) - 1
            if let delegate = nextTextFieldDelegate {
                delegate.nextField(indiceCampo, origen: type)
            }
        }
    }
    /// permite agregar barra de navegación si aplica
    func addToolbarToNumberPad() {
        let numberPadToolbar = KeyboardToolbar()
        numberPadToolbar.setup(leftButtons: [.atras], rightButtons: [.siguiente])
        numberPadToolbar.toolBarDelegate = self
        atributo?.inputAccessoryView = numberPadToolbar
    }
    //delegado para poder navegar entre los campos
    weak var nextTextFieldDelegate: NextTextFieldDelegate?
    @IBAction func btnModal(_ sender: Any) {
        controllerParent?.view.endEditing(true)
        self.mostrarModalParentesco(titulo:
            "Pokemon", rootController: controllerParent!)
    }
    //campo del atributo
    @IBOutlet var atributo: STextField?
    //boton para usar en caso de agenda
    @IBOutlet var agenda: UIButton?
    //delegado para la validación de los cambios
    weak var validarDelegate: ValidacionCampoSimpleDelegate?
    // en caso que se necesita abrir la agenda
    var controllerParent: UIViewController?
    //etiqueta mostrar
    @IBOutlet var etiqueta: UILabel?
    @IBOutlet weak var modalbtn: UIButton!
    //placeholder del atributo
    var placeholder: String? {
        didSet {
            atributo?.placeholder = self.placeholder
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    func setTag(tag: Int) {
        atributo?.tag = tag
    }
    //xib del atributo
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return "CampoSimpleCellView"
    }
    var pokemons: [PokemonModel]?
    //datos del atrbuto
    var campoSimple: CampoSimple? {
        didSet {
            //  atributo?.inputAccessoryView?.isHidden = false
            atributo?.spellCheckingType = .no
            atributo?.autocorrectionType = .no
            atributo?.returnKeyType = .continue
            if campoSimple?.tipo == .modal {
            } else {
                modalbtn.isHidden = true
                modalbtn.isEnabled = false
            }
            atributo?.hiddenIcon()
            ocultarAgenda = campoSimple?.tipo == .agenda
            asignarTipoTeclado()
        }
    }
    func asignarTipoTeclado() {
        if campoSimple?.tipo == .agenda {
            atributo?.keyboardType = .numberPad
        }
    }
    var value: String? {
        return atributo?.text
    }
    var ocultarAgenda: Bool? {
        didSet {
            agenda?.isHidden = !(self.ocultarAgenda ?? true)
            if !(self.ocultarAgenda ?? true) {
                atributo?.setRightPaddingPoints(55)
            }
        }
    }
    func endEditMonto(_ textField: UITextField) -> Bool {
        if textField.text?.hasSuffix(".") ?? false {
            atributo?.text = atributo?.text ?? ""  + "0"
        }
        return true
    }
    @IBAction func obtenerDatosAgenda(_ sender: Any) {
        let contacVC = CNContactPickerViewController()
        contacVC.delegate = self
        controllerParent?.present(contacVC, animated: true, completion: nil)
    }
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let numbers = contact.phoneNumbers.first
        var numeroFon = ((numbers?.value)?.stringValue ?? "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "503", with: "")
        if numeroFon.contains(find: ")") {
            let finArea = numeroFon.index(of: ")")!
            let area = numeroFon.prefix(upTo: numeroFon.index(after: finArea))
            numeroFon = "\(numeroFon.replacingOccurrences(of: area, with: "").inserting(separator: "-", every: 4))"
        } else {
            numeroFon = numeroFon.inserting(separator: "-", every: 4)
        }
        atributo?.text = String(numeroFon.prefix(9))
        atributo?.hiddenErrorValidation()
        campoSimple?.valor = String(numeroFon.prefix(9))
        if let validarDatos = validarDelegate {
            _ = validarDatos.validar(false)
        }
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        controllerParent?.dismiss(animated: true, completion: nil)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        if campoSimple?.tipo == .modal {
            return false
        }
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if replacementText.count > (campoSimple?.longitud ?? 1 ) {
            return false
        }
        var result = true
        if campoSimple?.tipo == .agenda {
            result = replacementText.replacingOccurrences(of: "-", with: "").isNumeric()
        }
        return result
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(textField.tag)
        return true
    }
    @IBAction func textFieldDidChange(_ sender: Any) {
        let texto = atributo?.text
        if campoSimple?.tipo == .agenda {
            atributo?.text = texto?.replacingOccurrences(of: "-", with: "").inserting(separator: "-", every: 4)
        } else if campoSimple?.tipo == .modal {
            atributo?.text = campoSimple?.valor ?? ""
        }
        campoSimple?.valor = atributo?.text
        if let validarDatos = validarDelegate {
            _ = validarDatos.validar(false)
        }
    }
    func mostrarModalParentesco(titulo: String, rootController: UIViewController) {
        let controller = CreateTeamViewController.instantiate()
        controller.pokemons = pokemons ?? []
        controller.delegate = self
        let  sizes: [SheetSize] = [.fixed(450.0), .fixed(550.0), .halfScreen]
        let sheetController = SheetViewController(controller: controller, sizes: sizes )
        //configuracion del modal de las cuentas
        sheetController.title = titulo
        sheetController.adjustForBottomSafeArea = true
        sheetController.blurBottomSafeArea = false
        sheetController.topCornersRadius = 40
        sheetController.dismissOnBackgroundTap = true
        sheetController.extendBackgroundBehindHandle = false
        sheetController.pullBarView.frame = CGRect(x: 0, y: 0, width: 20, height: 40)
        sheetController.pullBarView.isHidden = true
        //controller.tituloEncabezado = titulo
        rootController.present(sheetController, animated: false)
    }
}
protocol ValidacionCampoSimpleDelegate: class {
    func validar(_ general: Bool) -> Bool
    func cerrarTeclado()
}

extension CampoSimpleCellView: SelectPokemonDelegate {
    func selectPokemon(pokemonId: String) {
        atributo?.text = pokemonId
        atributo?.hiddenErrorValidation()
        campoSimple?.valor = pokemonId
    }
}

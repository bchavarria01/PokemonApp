//
//  AttributoCellView.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/6/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

/// celda para los atributos de pago de servicio
class AtributoCellView: BaseCeldaCellView, UITextFieldDelegate, KeyboardToolbarDelegate {
    func keyboardToolbar(button: UIBarButtonItem, type: KeyboardToolbarButton, tappedIn toolbar: KeyboardToolbar) {
        if type == .siguiente || type == .atras {
            let indiceCampo = type == .siguiente ?
                (atributo?.tag ?? 0) + 1  :   (atributo?.tag ?? 0) - 1
            if let delegate = nextTextFieldDelegate {
                delegate.nextField(indiceCampo, origen: type)
            }
        }
    }
    // validar y enviar dato de fecha seleccionada
    var validarFecha = false
    //campo del atributo
    @IBOutlet var atributo: STextField?
    //boton para la camara, en caso que aplique
    @IBOutlet var captura: UIButton?
    //etiqueta mostrar
    @IBOutlet var etiqueta: UILabel?
    //en caso que se utilice el escaneo es necesario sabe el controllar que prensentara
    // el modal de la captura de código
    var controllerParent: UIViewController?
    //delegado para la validación de los cambios
    weak var validarDelegate: ValidacionColecturiaDelegate?
    //delegado para poder navegar entre los campos
    weak var nextTextFieldDelegate: NextTextFieldDelegate?
    //si muestra la barra de navegación entre campos
    var showHelperKey: Bool?
    //datos del atrbuto
    var atributoColector: AtributoColector? {
        didSet {
            if let attr = self.atributoColector {
                var keyType: UIKeyboardType = .default
                switch attr.tipo {
                case .fecha:
                    self.atributo?.setInputViewDatePicker(target: self, selector: #selector(seleccionarFecha))
                case .moneda, .numero, .telefono :
                    if attr.ddecimales == 0 {
                        keyType = .numberPad
                    } else {
                        keyType = .decimalPad
                    }
                case .npe, .barra :
                    keyType = .numberPad
                case .correo:
                    keyType = .emailAddress
                default:
                    break
                }
                if showHelperKey ?? false {
                    if attr.tipo != .fecha {
                        addToolbarToNumberPad()
                        atributo?.inputAccessoryView?.isHidden = false
                    }
                } else if attr.tipo != .fecha {
                    atributo?.inputAccessoryView?.isHidden = true
                }
                atributo?.keyboardType = keyType
                atributo?.spellCheckingType = .no
                atributo?.autocorrectionType = .no
                atributo?.autocapitalizationType = .words
                atributo?.returnKeyType = .continue
                captura?.isHidden = !(self.atributoColector?.camara ?? false)
                atributo?.hiddenIcon()
                if self.atributoColector?.camara ?? false {
                    atributo?.setRightPaddingPoints(55)
                }
                captura?.isEnabled = attr.habilitado
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    /// permite agregar barra de navegación si aplica
    func addToolbarToNumberPad() {
        let numberPadToolbar = KeyboardToolbar()
        numberPadToolbar.setup(leftButtons: [.atras], rightButtons: [.siguiente])
        numberPadToolbar.toolBarDelegate = self
        atributo?.inputAccessoryView = numberPadToolbar
    }
    //placeholder del atributo
    var placeholder: String? {
        didSet {
            atributo?.placeholder = self.placeholder
        }
    }
    //nombre del name
    override var nibName: String? {
        return MontoCellView.identifier
    }
    //xib del atributo
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return "AtributoCellView"
    }
    var value: String? {
        return atributo?.text
    }
    func setTag(tag: Int) {
        atributo?.tag = tag
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    /// accion para captura el código
    ///
    /// - Parameter sender: boton de la acción
//    @IBAction func capturarBarra(_ sender: Any) {
//        if let controller = controllerParent {
//            let scanBarraController = ScanBarViewController.instantiate()
//            scanBarraController.delegate = self
//            scanBarraController.tipoScan = .barra
//            controller.present(scanBarraController, animated: false)
//        }
//    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        var result = true
        switch atributoColector!.tipo {
        case .moneda:
            result = endEditMonto(textField)
        case .numero:
            result =  endEditMonto(textField)
        case .telefono:
            result =  endEditMonto(textField)
        default:
            break
        }
        return result
    }
    func endEditMonto(_ textField: UITextField) -> Bool {
        if textField.text?.hasSuffix(".") ?? false {
            atributo?.text = atributo?.text ?? ""  + "0"
        }
        //asignarValor(monto: atributo?.text)
        return true
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if string.isEmpty {
//            return true
//        }
//        let currentText = textField.text ?? ""
//        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
//        if replacementText.count > (atributoColector?.llongitud ?? 1 ) && atributoColector!.tipo != .moneda {
//            return false
//        }
//        var result = true
//        switch atributoColector!.tipo {
//        case .moneda, .numero, .telefono:
//            if (atributoColector?.ddecimales ?? 0) >= 1 {
//                //  result =  replacementText.isValidDouble(maxDecimalPlaces: atributoColector?.ddecimales ?? 0,
//                //                                         maxIntPlaces: atributoColector?.llongitud ?? 1)
//                result =  replacementText.isValidDouble(maxDecimalPlaces: 2 ,
//                                                        maxIntPlaces: 6 )
//            } else {
//                if atributoColector!.tipo == .telefono {
//                    result = replacementText.replacingOccurrences(of: "-", with: "").isNumeric()
//                } else {
//                    result = replacementText.isNumeric()
//                }
//            }
//        case .fecha:
//            result = false //para que no permita que escriban la fecha
//        case .barra, .npe:
//            result =  replacementText.isNumeric()
//        case .texto:
//            break
//        default:
//            break
//        }
//        return result
//    }
    @IBAction func textFieldDidChange(_ sender: Any) {
        if atributoColector?.ddecimales ?? 0 > 0 {
            var  smonto =  atributo?.text?.trimmingCharacters(in: .whitespacesAndNewlines )
            if smonto?.hasPrefix(".") ?? false {
                smonto = "\(0)\(smonto ?? "")"
            }
            smonto = smonto?.uppercased().replacingOccurrences(of: "E", with: "")
            atributo?.text = smonto
        }
        if let atributoColect = atributoColector {
            let texto = atributo?.text
            if atributoColector?.tipo == .telefono {
                atributo?.text = texto?.replacingOccurrences(of: "-", with: "").inserting(separator: "-", every: 4)
            }
            atributoColect.valor = atributo?.text
            if let validarDatos = validarDelegate {
                _ = validarDatos.validar(false)
            }
        }
    }
    /// permite mostrar la seleción del la fecha
    @objc func seleccionarFecha() {
        if let datePicker = atributo?.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "dd/MM/yyyy"
            atributo?.text = dateformatter.string(from: datePicker.date)
        }
        atributo?.resignFirstResponder()
        if validarFecha {
            if let validarDatos = validarDelegate {
                atributoColector?.valor = atributo?.text ?? ""
                _ = validarDatos.validar(false)
            }
        }
    }
}

struct AtributoDetalle {
    var teclado: UIKeyboardType?
}
protocol ValidacionColecturiaDelegate: class {
    func validar(_ general: Bool) -> Bool
}
extension UITableView {
    func nextResponder(index: Int) {
        var currIndex = -1
        for i in index+1..<index+20 {
            if let view = self.superview?.superview?.viewWithTag(i) {
                view.becomeFirstResponder()
                currIndex = i
                break
            }
        }
        let ind = IndexPath(row: currIndex - 100, section: 0)
        if let nextCell = self.cellForRow(at: ind) {
            self.scrollRectToVisible(nextCell.frame, animated: true)
        }
    }
}

/// Permite agregar los botones para la navegación
class KeyboardToolbar: UIToolbar {
    weak var toolBarDelegate: KeyboardToolbarDelegate?
    init() {
        super.init(frame: .zero)
        barStyle = UIBarStyle.default
        isTranslucent = true
        sizeToFit()
        isUserInteractionEnabled = true
    }
    func setup(leftButtons: [KeyboardToolbarButton], rightButtons: [KeyboardToolbarButton]) {
        let leftBarButtons = leftButtons.map { (item) -> UIBarButtonItem in
            return item.createButton(target: self, action: #selector(buttonTapped))
        }
        let rightBarButtons = rightButtons.map { (item) -> UIBarButtonItem in
            return item.createButton(target: self, action: #selector(buttonTapped(sender:)))
        }
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        setItems(leftBarButtons + [spaceButton] + rightBarButtons, animated: false)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /// funcion que se utiliza para navegar entre los atributos mostrados
    ///
    /// - Parameter sender: boton de la acción
    @objc func buttonTapped(sender: UIBarButtonItem) {
        if let type = KeyboardToolbarButton.detectType(barButton: sender) {
            toolBarDelegate?.keyboardToolbar(button: sender, type: type, tappedIn: self)
        }
    }
}

protocol KeyboardToolbarDelegate: class {
    func keyboardToolbar(button: UIBarButtonItem, type: KeyboardToolbarButton, tappedIn toolbar: KeyboardToolbar)
}

/// enumeración para los tipos de botobes
///
/// - done: finalizar
/// - atras: retroceder
/// - siguiente: avanzar
/// - forward: NA
/// - forwardDisabled: NA
enum KeyboardToolbarButton: Int {
    case done = 0
    case atras
    case siguiente
    case forward, forwardDisabled
    func createButton(target: Any?, action: Selector?) -> UIBarButtonItem {
        var button: UIBarButtonItem!
        switch self {
        case .siguiente:
            button = UIBarButtonItem(title: "Siguiente", style: .plain, target: target, action: action)
        case .atras:
            button = UIBarButtonItem(title: "Atras", style: .plain, target: target, action: action)
        case .forward:
            button = UIBarButtonItem(title: "forward", style: .plain, target: target, action: action)
        case .forwardDisabled:
            button = UIBarButtonItem(title: "forward", style: .plain, target: target, action: action)
            button.isEnabled = false
        case .done:
            button = UIBarButtonItem(title: "done", style: .plain, target: target, action: action)
        }
        button.tintColor = #colorLiteral(red: 0.5098039216, green: 0.1882352941, blue: 0.8745098039, alpha: 1) //Color primario
        let barButtonAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5098039216, green: 0.1882352941, blue: 0.8745098039, alpha: 1)]
        button.setTitleTextAttributes(barButtonAttributes, for: .normal)
        button.tag = rawValue
        return button
    }
    static func detectType(barButton: UIBarButtonItem) -> KeyboardToolbarButton? {
        return KeyboardToolbarButton(rawValue: barButton.tag)
    }
}

protocol NextTextFieldDelegate: class {
    func nextField(_ tag: Int, origen: KeyboardToolbarButton)
}
extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "es_SV")
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancelar", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Aceptar", style: .plain, target: target, action: selector)
        cancel.tintColor = #colorLiteral(red: 0.5098039216, green: 0.1882352941, blue: 0.8745098039, alpha: 1)
        let barButtonAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5098039216, green: 0.1882352941, blue: 0.8745098039, alpha: 1)]
        cancel.setTitleTextAttributes(barButtonAttributes, for: .normal)
        barButton.setTitleTextAttributes(barButtonAttributes, for: .normal)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
extension StringProtocol where Self: RangeReplaceableCollection {
    /// Funcion para insertar separador en un texto
    ///
    /// - Parameters:
    ///   - separator: texto con el cual separara el string
    ///   - n: cada cuanto realizara la separacion
    mutating func insert(separator: Self, every n: Int) {
        for index in indices.reversed() where index != startIndex &&
            distance(from: startIndex, to: index) % n == 0 {
                insert(contentsOf: separator, at: index)
        }
    }
    mutating func insertando(separator: Self, every n: Int, from: Index) {
        for index in indices.reversed() where index != from && index != startIndex &&
            distance(from: from, to: index) % n == 0 {
                insert(contentsOf: separator, at: index)
        }
    }
    func insertingFrom(separator: Self, every n: Int, from: Index) -> Self {
        var string = self
        string.insertando(separator: separator, every: n, from: from)
        return string
    }
    /// Funcion para insertar separador
    ///
    /// - Parameters:
    ///   - separator: texto con el cual separara el string
    ///   - n: cada cuanto realizara la separacion
    /// - Returns: string formatiado
    func inserting(separator: Self, every n: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: n)
        return string
    }
}


//
//  Helper.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/4/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication
import SVProgressHUD
import SkyFloatingLabelTextField

protocol MessageHelper {
    
}
enum TipoMensaje {
    case informativo
    case error
    case advertencia
}
extension MessageHelper {
    func showError(_ msj: String? ) {
        if self is UIViewController || self is UINavigationController {
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Pokemon App", message: msj, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            let controller = self as? UIViewController
            DispatchQueue.main.async {
                controller?.present(alert, animated: false, completion: nil)
            }
        } else {
            SVProgressHUD.showError(withStatus: msj)
        }
        
    }
    func showError(_ msj: String?, ctrlPadre: UIViewController?) {
        if self is UIViewController || self is UINavigationController {
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Pokemon App", message: msj, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (_) in
                ctrlPadre?.dismiss(animated: true, completion: nil)
            }))
            let controller = self as? UIViewController
            DispatchQueue.main.async {
                controller?.present(alert, animated: false, completion: nil)
            }
        } else {
            SVProgressHUD.showError(withStatus: msj)
        }
    }
    func  dismissMsg() {
        SVProgressHUD.dismiss()
    }
    
    func showWait(_ msj: String? ) {
        SVProgressHUD.show(withStatus: msj)
    }
    
    func showAlert(titulo: String?, mensaje: String?, tipo: TipoMensaje) {
        
        showAlert(titulo: titulo, mensaje: mensaje, tipo: tipo, onComplete: nil)
    }
    func showAlert(titulo: String?, mensaje: String?, tipo: TipoMensaje, onComplete : (() -> Void)?) {
        if self is UIViewController {
            let controller = self as? UIViewController
            let alert = UIAlertController(title: "Pokemon App", message: mensaje, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (_) in
                onComplete?()
            }))
            DispatchQueue.main.async {
                controller?.present(alert, animated: false, completion: nil)
            }
        }
    }
    
}
extension SkyFloatingLabelTextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension String {
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeparator = formatter.decimalSeparator ?? "."
        if formatter.number(from: self) != nil {
            let split = self.components(separatedBy: decimalSeparator)
            let digits = split.count == 2 ? split.last ?? "" : ""
            return digits.count <= maxDecimalPlaces
        }
        return false
    }
    func isValidDouble(maxDecimalPlaces: Int, maxIntPlaces: Int) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeparator = formatter.decimalSeparator ?? "."
        if formatter.number(from: self) != nil {
            let split = self.components(separatedBy: decimalSeparator)
            if  (split.first?.count ?? 0) > maxIntPlaces {
                return false
            }
            let digits = split.count == 2 ? split.last ?? "" : ""
            return digits.count <= maxDecimalPlaces
        }
        return false
    }
    func containsCharactersIn(matchCharacters: String) -> Bool {
        let characterSet = NSCharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet as CharacterSet) != nil
    }
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = NSCharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
    func doesNotContainCharactersIn(matchCharacters: String) -> Bool {
        let characterSet = NSCharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet as CharacterSet) == nil
    }
    
    func isNumeric() -> Bool {
        if self.contains(".") ||  self.uppercased().contains("E") {
            return false
        }
        let scanner = Scanner(string: self)
        
        scanner.locale = Locale(identifier: "es_SV")
        
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

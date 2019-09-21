//
//  STextField.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/6/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class STextField: SkyFloatingLabelTextFieldWithIcon {
    var labelError: UILabel?
    var errorView: UIView?
    var originalColorSelect: UIColor?
    var originalColor: UIColor?
    var hasError = false
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        createLabelError()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func  showErrorValidation(msj: String?) {
        hasError = true
        if originalColor == nil {
            originalColor = lineColor
            originalColorSelect = selectedLineColor
        }
        if let errLabel = labelError {
            errorView?.isHidden = false
            errLabel.text = msj
            selectedLineColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            lineColor =  #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
    }
    func hiddenIcon() {
        iconWidth = 0
    }
    func  hiddenErrorValidation() {
        hasError = false
        errorView?.isHidden = true
        labelError?.text = ""
        selectedLineColor =  originalColorSelect ?? selectedLineColor
        lineColor = originalColor ?? lineColor
    }
    func createLabelError() {
        errorView = UIView(frame: CGRect(x: 0, y: self.frame.height+10, width: self.frame.width, height: 20))
        let imageError = UIImageView(frame: CGRect(x: 5, y: 0, width: 24, height: 20))
        imageError.image = UIImage(named: "error")
        imageError.contentMode = .scaleAspectFit
        errorView!.addSubview(imageError)
        labelError = UILabel(frame: CGRect(x: 40, y: 0, width: self.frame.width, height: 20))
        labelError?.text = ""
        labelError?.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        let num: CGFloat = 12
        labelError?.font = .boldSystemFont(ofSize: num)
        errorView?.addSubview(labelError!)
        errorView?.isHidden = true
        addSubview(errorView!)
    }
    
}


//
//  SimpleView.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/6/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Foundation
import UIKit
class SimpleView: UIView {
    //vista base
}

extension UIView {
    
    func addDashedBorder() {
        let color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.bounds.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6, 3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func addDashedBorder2(_ color: UIColor = UIColor.black,
                          withWidth width: CGFloat = 2,
                          cornerRadius: CGFloat = 5,
                          dashPattern: [NSNumber] = [3, 6]) {
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        
        shapeLayer.bounds = self.bounds
        shapeLayer.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.path = UIBezierPath(roundedRect: self.frame, cornerRadius: cornerRadius).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UIView {
    
    func shake(for duration: TimeInterval = 0.5, withTranslation translation: Float = 5) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            
            self.transform = CGAffineTransform(translationX: CGFloat(translation), y: 0)
        }
        
        propertyAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        
        propertyAnimator.addCompletion { (_) in
            //no se utiliza
        }
        
        propertyAnimator.startAnimation()
        
    }
}


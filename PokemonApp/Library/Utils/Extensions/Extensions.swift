//
//  Extensions.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/4/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit

extension UIView {
    func cornerRadius(with corners: CACornerMask, cornerRadii: CGFloat) {
        self.layer.cornerRadius = cornerRadii
        self.layer.maskedCorners = corners
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
    
    func getImageUrl() -> String {
        let newUrl = self.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species",
                                                      with: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon")
        return "\(newUrl.dropLast()).png"
        
    }
    
    func getColorByPokemonColor() -> UIColor {
        switch self {
        case "black":
            return R.Colors.pokemonBlack.color
        case "red":
            return R.Colors.pokemonRed.color
        case "blue":
            return R.Colors.pokemonBlue.color
        case "gray":
            return R.Colors.pokemonGray.color
        case "pink":
            return R.Colors.pokemonPink.color
        case "brown":
            return R.Colors.pokemonBrown.color
        case "green":
            return R.Colors.pokemonGreen.color
        case "white":
            return R.Colors.pokemonWhite.color
        case "purple":
            return R.Colors.pokemonPurple.color
        case "yellow":
            return R.Colors.pokemonYellow.color
        default:
            return R.Colors.pokemonRed.color
        }
    }
}

extension UIImageView {
    func rotateImageInfinite() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = -Double.pi * 2 //Minus can be Direction
        rotationAnimation.toValue = 0.0
        rotationAnimation.duration = 10
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.speed = 10
        self.layer.add(rotationAnimation, forKey: "rotateInfinite")
    }
    
    func stopRotation() {
        self.layer.removeAnimation(forKey: "rotateInfinite")
    }
    
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

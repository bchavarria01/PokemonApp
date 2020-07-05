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

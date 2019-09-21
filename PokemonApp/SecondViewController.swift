//
//  SecondViewController.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/3/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    static func instantiate() -> SecondViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondViewController") as! SecondViewController
    }

}


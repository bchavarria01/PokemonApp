//
//  K.swift
//  base-ios
//
//  Created by Gustavo Lopez on 7/2/19.
//  Copyright © 2019 Gustavo Lopez. All rights reserved.
//

import UIKit
import Nuke
import Moya

enum K {
    static let baseURL = "https://pokeapi.co/api/v2/"
    
    enum Components {
        static let navigationBarHeight: CGFloat = 64
    }
    
    enum PokemonServices {
        static let Pokemons = URL(string: "\(baseURL)/pokemon?&limit=964")!
        static let region = URL(string: "\(baseURL)/region")!
    }
    
    // Nuke
    enum Nuke {
        static let options = ImageLoadingOptions(
            placeholder: R.Base.player.image,
            transition: .fadeIn(duration: 0.33)
        )
    }
    
    // Moya
    enum MoyaDefaults {
        static let plugins: [PluginType] = [
            NetworkLoggerPlugin(),
            RequestPlugin()
        ]
        static let secureMethods: [Moya.Method] = [.get, .post]
        static let defaultHeaders = [
            "Content-Type": "application/json",
        ]
    }
    
    // Security
    enum Security {
        static let ivSize = 16
        static let keySize = 32
        static let saltSize = 32
        static let secretKey = "ws_endpoint_ebanking_ios_android"
        
        enum Keys {
            static let data = "Data"
            static let code = "Code"
            static let message = "Mensaje"
        }
    }
}

//
//  BaseResponse.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 8/3/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Foundation
class BaseResponse: Decodable {
    var msj: String?
    var codMsj: String?
    var errorCode: String?
    var closeSession = false
    var requestData: Any?
    var rawResponse: Data?
    
    init(code: String?, msj: String?) {
        codMsj = code
        self.msj = msj
    }
    private enum CodingKeys: String, CodingKey {
        case msj = "Msj"
        case codMsj = "CodMsj"
        case errorCode = "errorCode"
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        msj = try container.decodeIfPresent(String.self, forKey: .msj)
        codMsj = try container.decodeIfPresent(String.self, forKey: .codMsj)
        errorCode = try container.decodeIfPresent(String.self, forKey: .errorCode)
    }
}

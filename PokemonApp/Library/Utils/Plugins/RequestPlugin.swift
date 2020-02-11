//
//  RequestPlugin.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 12/21/19.
//  Copyright © 2019 Byron Chavarría. All rights reserved.
//

import Foundation
import Moya

final class RequestPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
//        let isSecureMethod = K.MoyaDefaults.secureMethods.contains(target.method)
//        guard isSecureMethod else { return request }
        switch target.task {
        case let .requestParameters(parameters, _):
            var secureRequest = request
            do {
                secureRequest.httpBody = try JSONSerialization.data(
                    withJSONObject: parameters,
                    options: .prettyPrinted
                )
                
                return secureRequest
            } catch {}
            
        default: break
        }
        return request
    }
    
    // MARK: - Prepare Response
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        switch result {
        case let .success(response):
            do {
                let jsonData = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                let plainRequestData = try JSONSerialization.data(
                    withJSONObject: jsonData,
                    options: []
                )
                
                let plainResponse = Response(
                    statusCode: response.statusCode,
                    data: plainRequestData,
                    request: response.request,
                    response: response.response
                )
                return .success(plainResponse)
                
            } catch {}
            
        default: break
        }
        return result
    }
    
}

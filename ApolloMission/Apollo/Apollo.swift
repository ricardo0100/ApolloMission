//
//  ApolloClient.swift
//  ApolloMission
//
//  Created by Ricardo Gehrke Filho on 08/11/17.
//  Copyright © 2017 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import Apollo

class Apollo {
    
    static let API_URL = "https://api.graph.cool/simple/v1/cj6pwzyjj12yr0181kqi0zspz"
    
    static let shared = Apollo()
    
    var client: ApolloClient? = {
        guard let url = URL(string: API_URL) else { return nil }
        let apolloClient = ApolloClient(url: url)
        
        //This makes the id field the identifier of each object in the cache. This makes possible to keep cache consistent and always updated.
        apolloClient.cacheKeyForObject = {
            $0["id"]
        }
        
        return apolloClient
    }()
    
}

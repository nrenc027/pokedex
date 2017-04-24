//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ren Cummings on 4/24/17.
//  Copyright © 2017 Ren Cummings. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokeDexId: Int!
    
    var name: String {
        
        return _name
    }
    
    var pokeDexId: Int {
        
        
        
        return _pokeDexId
    }
    
    
    init(name: String, pokeDexId: Int) {
       
        
        self._name = name
        self._pokeDexId = pokeDexId
        
    }
    
    
}

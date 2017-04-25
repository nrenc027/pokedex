//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ren Cummings on 4/24/17.
//  Copyright © 2017 Ren Cummings. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokeDexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvo: String!
    private var _pokemonURL: String!
    
    //getters
    
    var description: String {
        if _description == nil {
            
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            
            _attack = ""
        }
        return _attack
    }
    
    var nextEvo: String {
        if _nextEvo == nil {
            
            _nextEvo = ""
        }
        return _nextEvo
    }
    
    var name: String {
        
        return _name
    }
    
    var pokeDexId: Int {
        
        
        
        return _pokeDexId
    }
    
    //End Getters
    
    
    init(name: String, pokeDexId: Int) {
        
        
        self._name = name
        self._pokeDexId = pokeDexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokeDexId)"
        
    } // end init
    
    
    
    func downloadPokeDetail(completed: @escaping DownloadComplete){
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                //weight
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                //height
                if let height = dict["height"] as? String {
                    self._height = height
                }
                //attack
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                //defense
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
               
                //type
                if let types = dict["types"] as? [Dictionary<String,String>] , types.count > 0 {
                   //if only 1
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    //if more than 1
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "\(name.capitalized)"
                            }
                        }
                    }
                    
                    
                } else { // if none
                    self._type = ""
                }
                //description
                
                
            }
            
            completed()
            
        }
        
    }//end downloadPokeDetail
    
} //end class

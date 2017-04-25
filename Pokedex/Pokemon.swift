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
    private var _nextEvoName: String!
    private var _nextEvoID: String!
    private var _nextEvoLvl: String!
    private var _pokemonURL: String!
    
    //getters
   
    var nextEvoLvl: String {
        if _nextEvoLvl == nil {
            
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
   
    
    var nextEvoID: String {
        if _nextEvoID == nil {
            
            _nextEvoID = ""
        }
        return _nextEvoID
    }
    
    var nextEvoName: String {
        if _nextEvoName == nil {
            
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
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
                
                if let describeArr = dict["descriptions"] as? [Dictionary<String, String>] , describeArr.count > 0 {
                    
                    //only using first
                    if let url = describeArr[0]["resource_uri"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                        
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                  let  newDescribe = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._description = newDescribe
                                    
                                  
                                    
                                  
                                }
                                
                            }
                            completed()
                        
                        })
                    }
                    
                } else {
                    self._description = ""
                }
               
                //evolution
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvoName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvoID = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    
                                    if let lvl = lvlExist as? Int {
                                        
                                        self._nextEvoLvl = "\(lvl)"
                                    }
                                    
                                } else {
                                    
                                    self._nextEvoLvl = ""
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    print(self.nextEvoLvl)
                    print(self.nextEvoName)
                    print(self.nextEvoID)
                }
                
                 
                
            }//end opening of initial dictionary
            
            completed()
            
        }//end first call to JSON
        
    }//end downloadPokeDetail
    
} //end class

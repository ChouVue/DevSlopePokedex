//
//  Pokemon.swift
//  DevSlopePokedex
//
//  Created by Chou Vue on 10/4/17.
//  Copyright © 2017 VUE. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon
{
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    /*
     Getter Syntax
     
     You want to be able to protect the data and make sure that you are only providing either an
     "Actual Value" or if the value is "nil" because you can`t guarantee that all of the "Value"
     has a "Value"/"Actual Value".
     
     This is called "Data Protectiong" / "Data Hiding"
     */
    
    var name: String
    {
        if _name == nil
        {
            _name = ""
        }
        return _name
    }
    
    var pokedexId: Int
    {
        if _pokedexId == nil
        {
            _pokedexId = 0
        }
        return _pokedexId
    }
    
    var description: String
    {
        if _description == nil
        {
            _description = ""
        }
        return _description
    }
    
    var type: String
    {
        if _type == nil
        {
            _type = ""
        }
        return _type
    }
    
    var defense: String
    {
        if _defense == nil
        {
            _defense = ""
        }
        return _defense
    }
    
    var height: String
    {
        if _height == nil
        {
            _height = ""
        }
        return _height
    }
    
    var weight: String
    {
        if _weight == nil
        {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String
    {
        if _attack == nil
        {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String
    {
        if _nextEvolutionTxt == nil
        {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionName: String
    {
        if _nextEvolutionName == nil
        {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String
    {
        if _nextEvolutionId == nil
        {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String
    {
        if _nextEvolutionLevel == nil
        {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    init(name: String, pokedexId: Int)
    {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_Base)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete)
    {
        Alamofire.request(_pokemonURL).responseJSON
        { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject>
            {
                if let weight = dict["weight"] as? String
                {
                    self._weight = weight
                }
                if let height = dict["height"] as? String
                {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int
                {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int
                {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0
                {
                    //If there is only 1 type, then this If Statement code will be call
                    if let name = types[0]["name"]
                    {
                        self._type = name.capitalized
                    }
                    
                    //If there is more than 1 type, then this If Statement code will be call
                    if types.count > 0
                    {
                        //This will loop through however many dictionary there are in "types"
                        for x in 1..<types.count
                        {
                            //It will look for every "KEY" with the attribute "name"
                            if let name = types[x]["name"]
                            {
                                //Then it will take the value of that and it will then add onto the "FIRST IF STATEMENT" that was run
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                        else
                        {
                            self._type = ""
                        }
                    
                    if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0
                    {
                        if let url = descArr[0]["resource_uri"]
                        {
                            let descURL = "\(URL_Base)\(url)"
                            
                            Alamofire.request(descURL).responseJSON(completionHandler:
                            {(response) in
                            
                                if let descDict = response.result.value as? Dictionary<String, AnyObject>
                                {
                                    if let description = descDict["description"] as? String
                                    {
                                        let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                        self._description = newDescription
                                    }
                                }
                                completed()
                            })
                        }
                    }
                        else
                        {
                            self._description = ""
                        }
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0
                    {
                        if let nextEvo = evolutions[0]["to"] as? String
                        {
                            if nextEvo.range(of: "mega") == nil
                            {
                                self._nextEvolutionName = nextEvo
                                
                                if let uri = evolutions[0]["resource_uri"] as? String
                                {
                                    let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    let nextEvoId = newString.replacingOccurrences(of: "/", with: "")
                                    
                                    self._nextEvolutionId = nextEvoId
                                    
                                    if let lvlExist = evolutions[0]["level"]
                                    {
                                        if let level = lvlExist as? Int
                                        {
                                            self._nextEvolutionLevel = "\(level)"
                                        }
                                    }
                                        else
                                        {
                                            self._nextEvolutionLevel = ""
                                        }
                                }
                            }
                        }
                    }
                    
                }
            }
            completed()
        }
    }
}

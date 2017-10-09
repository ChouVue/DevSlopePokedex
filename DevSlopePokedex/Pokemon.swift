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
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
            }
            
            completed()
        }
    }
}

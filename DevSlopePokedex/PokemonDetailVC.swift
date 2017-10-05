//
//  PokemonDetailVC.swift
//  DevSlopePokedex
//
//  Created by Chou Vue on 10/5/17.
//  Copyright © 2017 VUE. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalized

    }

    

}

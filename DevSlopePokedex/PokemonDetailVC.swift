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
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalized

        pokemon.downloadPokemonDetail
        {
            //Whatever we write here will only be called after the network call is complete!
            /* Here what we want:
                -Whenever the data is available, we want to update the UI to have that data
            */
            
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
    }

    @IBAction func backBtnPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    

}

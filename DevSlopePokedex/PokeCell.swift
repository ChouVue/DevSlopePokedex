//
//  PokeCell.swift
//  DevSlopePokedex
//
//  Created by Chou Vue on 10/4/17.
//  Copyright © 2017 VUE. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell
{
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder)
    {
        //Each View Have A Layer Level Cell
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon)
    {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}

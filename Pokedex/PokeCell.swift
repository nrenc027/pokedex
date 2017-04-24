//
//  PokeCell.swift
//  Pokedex
//
//  Created by Ren Cummings on 4/24/17.
//  Copyright © 2017 Ren Cummings. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeThumb: UIImageView!
    @IBOutlet weak var pokeLbl: UILabel!
    
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    
    func configCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        pokeLbl.text = self.pokemon.name.capitalized
        pokeThumb.image = UIImage(named: "\(self.pokemon.pokeDexId)")
        
        
    }
 
}

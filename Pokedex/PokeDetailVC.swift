//
//  PokeDetailVC.swift
//  Pokedex
//
//  Created by Ren Cummings on 4/24/17.
//  Copyright © 2017 Ren Cummings. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {

  var pokemon: Pokemon!
   
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var describeLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var BALbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var curEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       nameLbl.text = pokemon.name.capitalized
        let img = UIImage(named: "\(pokemon.pokeDexId)")
        mainImg.image = img
        curEvoImg.image = img
        pIDLbl.text = "\(pokemon.pokeDexId)"
        
        pokemon.downloadPokeDetail {
            //call after netwrok call complete
            
            print("Did arrive here?")
            
            self.updateUI()
            
        }
        
    }
    func updateUI() {
        
        
       
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        BALbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        typeLbl.text = pokemon.type
        describeLbl.text = pokemon.description
        
        if pokemon.nextEvoID == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoID)
            let str = "Next Evolution: \(pokemon.nextEvoName) - LVL: \(pokemon.nextEvoLvl)"
            evoLbl.text = str
        }
        
        
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }



}

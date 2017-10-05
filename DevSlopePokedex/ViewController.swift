//
//  ViewController.swift
//  DevSlopePokedex
//
//  Created by Chou Vue on 10/4/17.
//  Copyright © 2017 VUE. All rights reserved.
//

import UIKit
import AVFoundation

//UICollectionViewDelegate: Tell that this is the class (IN THIS FILE) is going to be the DELEGATE for the collection view

//UICollectionViewDataSource: Tell that this is the class that is going to hold the DATA for the collection view

//UICollectionViewDelegateFlowLayout: The protocol use to MODIFIED and set the SETTING for the layout for the collection view

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        parsePokemonCSV()
        initAudio()
        
    }
    
    func initAudio()
    {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do
        {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV()
    {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do
        {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows
            {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell
        {
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 90, height: 90)
    }
    
    @IBAction func musicBtnPressed(_ sender: UIButton)
    {
        if musicPlayer.isPlaying
        {
            musicPlayer.pause()
            sender.alpha = 0.2
        }
        else
        {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    


}


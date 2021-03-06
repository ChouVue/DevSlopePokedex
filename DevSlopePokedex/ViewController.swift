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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
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
            let poke: Pokemon!
            
            if inSearchMode
            {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
            }
            else
            {
                //If we are not in search mode, then poke is equal to pokemon from the original array
                poke = pokemon[indexPath.row]
                
                //Then were going to set that in
                cell.configureCell(poke)
            }
            
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        var poke: Pokemon!
        
        if inSearchMode
        {
            poke = filteredPokemon[indexPath.row]
        }
        else
        {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "ViewControllerToPokemonDetailVC", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if inSearchMode
        {
            return filteredPokemon.count
        }
        
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text == nil || searchBar.text == ""
        {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        }
        else
        {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            //Basically saying: The "filteredPokemon (filteredPokemon)" list  is going to be "equal (=)" to the "orignal pokemon list (pokemon)" but it`s "filter (.filter)" and how we are filtering it is:
                                    //The "Dollar Sign & Zero($0)" is kind of a place holder for any and all of the object in the original pokemon array
                                    //Where taking the name value of that "(.name)" 
                                    //Then is what we put in the search bar contain any inside of that name "(.rang(of: lower)) != nill)
                                    //*(lower) = "let lower = searchBar.text!.lowercased()"
                                    //And if it is, then we are going to put that into the pokemon filtered list
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            
            collection.reloadData()
        }
    }
    
    //Here we are preparing the "Segue" and will be sending "AnyObject"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //Saying: If the segue identifier is "ViewControllerToPokemonDetailVC"
        if segue.identifier == "ViewControllerToPokemonDetailVC"
        {
            //Then we are going to create a variable for "detailVC" and the destination view controller is "PokemonDetailVC"
            if let detailsVC = segue.destination as? PokemonDetailVC
            {
                //And then were going to create "poke" as a sender as a class "Pokemon"
                if let poke = sender as? Pokemon
                {
                    //"detailVC" is what we defined as the destination view controller
                    //"pokemon" is the variable we created in "PokemonDetailVC"
                    //Saying: The destination view controller (detailsVC) that contain the variable "pokemon", we are setting it to this View Controller variable "poke"
                    detailsVC.pokemon = poke
                }
            }
        }
    }
}


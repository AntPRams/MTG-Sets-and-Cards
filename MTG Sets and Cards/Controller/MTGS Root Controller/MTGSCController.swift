//
//  ViewController.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 04/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTGSCController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .clear
            let nib = UINib(nibName: SetCollectionViewCell.identifier, bundle: .main)
            collectionView.register(nib, forCellWithReuseIdentifier: SetCollectionViewCell.identifier)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
            let nib = UINib(nibName: CardTableViewCell.identifier, bundle: .main)
            tableView.register(nib, forCellReuseIdentifier: CardTableViewCell.identifier)
        }
    }
    
    @IBOutlet weak var mainStackView:  UIStackView!
    @IBOutlet weak var setDetailsView: SetDetailsView!
    
    //MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var collectionOfSets:         [MtgSet] = []
    var filteredCollectionOfSets: [MtgSet] = []
    var collectionOfCards:        [MtgCard] = []
    var selectedSet: MtgSet!
    
    //MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        setDetailsView.isHidden = true
        
        MTGBigarClient.taskForGetRequest(url: MTGBigarClient.generateUrl(), handler: handleSetsResponse(response:error:))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setBackgroundImage()
    }
    
    //MARK: Actions
    
    @IBAction func presentFiltersController(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "FiltersController", bundle: .main)
        guard let controller = storyboard.instantiateViewController(identifier: "FiltersController") as? FiltersController else {return}
        controller.collectionOfSets = collectionOfSets
        controller.delegate = self
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true)
    }
    
    //MARK: Methods
    
    private func handleSetsResponse(response: JSON?, error: Error?) {
        
        if error == nil {
            guard let response = response else {return}
            
            let data = response["data"]
            data["allExpansions"].array!.forEach {
                
                let set = MtgSet(
                    name:        $0["name"].stringValue,
                    id:          $0["id"].stringValue,
                    code:        $0["code"].stringValue,
                    releaseDate: $0["releaseDate"].stringValue,
                    cardCount:   $0["cardCount"].intValue,
                    block:       $0["block"].stringValue
                )
                collectionOfSets.append(set)
            }
            collectionView.reloadData()
        } else {
            presentAlert(message: error?.localizedDescription)
        }
    }
    
    func handleCardsResponse(response: JSON?, error: Error?) {
        
        if error == nil {
            guard let response = response else {return}
            
            let data = response["data"]
            collectionOfCards.removeAll()
            
            data["allExpansionCards"].array!.forEach({
                
                let name =     $0["name"][languageCurrentlySelected].stringValue
                let manaCost = $0["manacost"].stringValue
                let artCropUrl = URL(string: $0["imageUrls"][0]["artcrop"].stringValue)
                let largeImageUrl = URL(string: $0["imageUrls"][0]["normal"].stringValue)
                let rarity = $0["rarity"].stringValue
                let type = $0["type"][languageCurrentlySelected].stringValue
                let releaseDate = selectedSet.releaseDate
                
                let card = MtgCard(
                    name: name,
                    largeImageUrl: largeImageUrl!,
                    artCropImageUrl: artCropUrl!,
                    manaCost: manaCost,
                    rarity: rarity,
                    type: type,
                    setReleaseDate: releaseDate
                )
                collectionOfCards.append(card)
            })
        } else {
            presentAlert(message: error?.localizedDescription)
        }
        tableView.reloadData()
    }
}

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

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .clear
            let nib = UINib(nibName: SetCollectionViewCell.identifier, bundle: .main)
            collectionView.register(nib, forCellWithReuseIdentifier: SetCollectionViewCell.identifier)
        }
    }
    
    @IBOutlet weak var setDetailsView: SetDetailsView!
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
            let nib = UINib(nibName: CardTableViewCell.identifier, bundle: .main)
            tableView.register(nib, forCellReuseIdentifier: CardTableViewCell.identifier)
        }
    }
    
    var collectionOfSets:  [MtgSet] = []
    var collectionOfCards: [MtgCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.dataSource = self
        
        MTGBigarClient.taskForGetRequest(url: MTGBigarClient.generateUrl(), handler: handleSetsResponse(response:error:))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBackgroundImage()
    }
    
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
            print(error!.localizedDescription)
        }
    }
    
    func handleCardsResponse(response: JSON?, error: Error?) {
        
        if error == nil {
            guard let response = response else {return}
            
            let data = response["data"]
            collectionOfCards.removeAll()
            
            data["allExpansionCards"].array!.forEach({
                
                let name =     $0["name"]["jp"].stringValue
                let manaCost = $0["manacost"].stringValue
                let artCropUrl = URL(string: $0["imageUrls"][0]["artcrop"].stringValue)
                let largeImageUrl = URL(string: $0["imageUrls"][0]["large"].stringValue)
                let rarity = $0["rarity"].stringValue
                let type = $0["type"]["jp"].stringValue
                
                let card = MtgCard(
                    name: name,
                    largeImageUrl: largeImageUrl!,
                    artCropImageUrl: artCropUrl!,
                    manaCost: manaCost,
                    rarity: rarity,
                    type: type
                )
                collectionOfCards.append(card)
            })
        } else {
            print(error!.localizedDescription)
        }
        tableView.reloadData()
    }
    
    func setBackgroundImage() {
        
        let backgroundImageView = UIImageView()

        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
   
        view.insertSubview(backgroundImageView, at: 0)
        
        backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

extension MTGSCController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionOfCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.identifier) as! CardTableViewCell
        let model = collectionOfCards[indexPath.row]
        
        cell.setupCellWith(model)
        return cell
    }
}

extension MTGSCController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MTGSCController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionOfSets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: SetCollectionViewCell.identifier, for: indexPath) as! SetCollectionViewCell
        let model = collectionOfSets[indexPath.row]
        
        cell.setupCellWith(model)
        cell.backgroundColor = .clear
        
        return cell
    }

}

extension MTGSCController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = collectionOfSets[indexPath.row]
        setDetailsView.setupViewWith(model)
        MTGBigarClient.taskForGetRequest(
            url:     MTGBigarClient.generateUrl(for: "/\(model.id)"),
            handler: handleCardsResponse(response:error:)
        )
    }
}

extension MTGSCController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 10
        
        let totalHeight = collectionView.frame.height - (spacing * 2)
        let totalWidth =  collectionView.frame.width - (spacing * 2)
        
        return CGSize(width: totalWidth, height: totalHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

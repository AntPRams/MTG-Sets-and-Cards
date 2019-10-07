//
//  MTGSController+UITableViewDelegate.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 07/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

extension MTGSCController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = collectionOfCards[indexPath.row]
        
        if let controller = storyboard?.instantiateViewController(identifier: "CardPresenterController") as? CardPresenterController {
            
            controller.stringUrl = card.largeImageUrl
            controller.modalPresentationStyle = .overCurrentContext
            controller.modalTransitionStyle = .crossDissolve
            present(controller, animated: true)
            
        }
    }
}

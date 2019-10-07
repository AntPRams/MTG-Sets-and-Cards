//
//  MTGSController+UITableViewDataSource.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 07/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

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
        cell.handleError = { (error) in
            self.presentAlert(message: error?.localizedDescription)
        }
        cell.setupCellWith(model)
        return cell
    }
}

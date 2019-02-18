//
//  PlayersViewController.swift
//  Ratings
//
//  Created by Milica Jankovic on 12/29/18.
//  Copyright © 2018 Milica Jankovic. All rights reserved.
//

import UIKit

class PlayersViewController: UITableViewController {

  
  // MARK: Properties
  var players = SampleData.generatePlayersData()
  

  // MARK: UITableViewDataSource
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

 
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
    
    let player = players[indexPath.row]
    cell.player = player
    return cell
  }
}

// MARK: IBActions
extension PlayersViewController {
  @IBAction func cancelToPlayersViewController(_ segue: UIStoryboardSegue) {
    
  }
  
  @IBAction func savePlayerDetail(_ segue: UIStoryboardSegue) {
    guard let playerDetailsViewController = segue.source as? PlayerDetailsViewController,
      let player = playerDetailsViewController.player else {
        return
    }
    
    players.append(player)
    let indexPath = IndexPath(row: players.count - 1, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }
}


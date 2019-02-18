//
//  GamePickerViewController.swift
//  Ratings
//
//  Created by Milica Jankovic on 12/29/18.
//  Copyright © 2018 Milica Jankovic. All rights reserved.
//

import UIKit

class GamePickerViewController: UITableViewController {

  // MARK: Properties
  var games = [
    "Angry Birds",
               "Chess",
               "Russian Roulette",
               "Spin the Bottle",
               "Texas Hold'em Poker",
               "Tic-Tac-Toe"
  ]
  
  var selectedGame: String? {
    didSet{
      if let selectedGame = selectedGame,
        let index = games.index(of: selectedGame) {
        selectedGameIndex = index
      }
    }
  }
  var selectedGameIndex: Int?
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "SaveSelectedGame", let cell = sender as? UITableViewCell,
      let indexPath = tableView.indexPath(for: cell) else {
        return
    }
    let index = indexPath.row
    selectedGame = games[index]
  }
}

  // MARK: UITableViewDataSource
  
  extension GamePickerViewController  {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
    cell.textLabel?.text = games[indexPath.row]
    
    if  indexPath.row == selectedGameIndex {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
    return cell
  }
}

// MARK: UITableViewDelegate
extension GamePickerViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    if let index = selectedGameIndex {
      let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
      cell?.accessoryType = .none
    }
    
    selectedGame = games[indexPath.row]
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .checkmark
  }
  
}

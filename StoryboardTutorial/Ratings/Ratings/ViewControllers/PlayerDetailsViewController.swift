//
//  PlayerDetailsViewController.swift
//  Ratings
//
//  Created by Milica Jankovic on 12/29/18.
//  Copyright © 2018 Milica Jankovic. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UITableViewController {

  // MARK: Properties
  var player: Player?
  var game: String = "Chess" {
    didSet{
      detailLabel.text = game
    }
  }
  
  // MARK: Outlets
  @IBOutlet weak var nameTextField: UITextField!
  
  @IBOutlet weak var detailLabel: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()
  }
  
  // MARK: - Initializers
  required init?(coder aDecoder: NSCoder) {
    print("init PlayerDetailsViewController")
    super.init(coder: aDecoder)
  }
  
  deinit {
    print("deinit PlayerDetailsViewController")
  }

  // MARK: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SavePlayerDetail", let playerName = nameTextField.text {
      player = Player(name: playerName, game: game, rating: 1)
    }
    if segue.identifier == "PickGame",
      let gamePickerViewController = segue.destination as? GamePickerViewController {
      gamePickerViewController.selectedGame = game
    }
  }
}

// MARK: IBAction
extension PlayerDetailsViewController {
  @IBAction func unwindWithSelectedGame(segue: UIStoryboardSegue) {
    if let gamePickerViewController = segue.source as? GamePickerViewController,
      let selectedGame = gamePickerViewController.selectedGame {
        game = selectedGame
      }
    }
  }

// MARK: UITableViewDelegate

extension PlayerDetailsViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      nameTextField.becomeFirstResponder()
    }
  }
}

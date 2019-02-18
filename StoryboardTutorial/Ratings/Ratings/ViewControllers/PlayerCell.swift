//
//  PlayerCell.swift
//  Ratings
//
//  Created by Milica Jankovic on 12/29/18.
//  Copyright © 2018 Milica Jankovic. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

  // MARK: Outlets
  @IBOutlet weak var gameLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingImageView: UIImageView!
  
  
  // MARK: Properties
  var player: Player? {
    didSet{
      guard let player = player else { return }
      gameLabel.text = player.game
      nameLabel.text = player.name
      ratingImageView.image = image(forRating: player.rating)
    }
  }
  
  func image(forRating rating: Int) -> UIImage? {
    let imageName = "\(rating)Stars"
    return UIImage(named: imageName)
  }
}

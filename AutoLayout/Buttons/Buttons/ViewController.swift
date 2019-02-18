//
//  ViewController.swift
//  Buttons
//
//  Created by Milica Jankovic on 12/30/18.
//  Copyright © 2018 Milica Jankovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBAction func buttonTapped(_ sender: UIButton) {
    if sender.title(for: .normal) == "X" {
      sender.setTitle("A very long title for this button", for: .normal)
    } else {
      sender.setTitle("X", for: .normal)
    }
  }
}


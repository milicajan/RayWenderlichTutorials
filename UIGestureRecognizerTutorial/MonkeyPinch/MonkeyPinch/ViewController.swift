/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import  AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet var monkeyPan: UIPanGestureRecognizer!
  @IBOutlet var bananaPan: UIPanGestureRecognizer!
  
  var chompPlayer: AVAudioPlayer? = nil
  var hehePlayer:AVAudioPlayer? = nil
  
  func loadSound(filename: String) -> AVAudioPlayer {
    let url = Bundle.main.url(forResource: filename, withExtension: "caf")
    var player = AVAudioPlayer()
    do{
      try player = AVAudioPlayer(contentsOf: url!)
      player.prepareToPlay()
    } catch {
      print("Error loading \(url!): \(error.localizedDescription)")
    }
    return player
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let filterdSubviews = self.view.subviews.filter({$0 is UIImageView})
    
    for view in filterdSubviews {
      let recognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap(recognizer:)))
      recognizer.delegate = self
      view.addGestureRecognizer(recognizer)
      recognizer.require(toFail: monkeyPan)
      recognizer.require(toFail: bananaPan)
    }
    
    let recognizer2 = TickleGestureRecognizer(target: self,  action:#selector(handleTickle(recognizer:)))
    recognizer2.delegate = self
    view.addGestureRecognizer(recognizer2)
    self.hehePlayer = self.loadSound(filename: "hehehe1")
    self.chompPlayer = self.loadSound(filename: "chomp")
  }
  
  @IBAction func hanlePan(recognizer: UIPanGestureRecognizer) {
    let translation = recognizer.translation(in: self.view)
    if let view = recognizer.view {
      view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
    }
    recognizer.setTranslation(CGPoint.zero, in: self.view)
    
    if recognizer.state == UIGestureRecognizerState.ended {
     
      let velocity = recognizer.velocity(in: self.view)
      let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
      let slideMultiplier = magnitude / 200
      print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
      
      let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
   
      var finalPoint = CGPoint(x:recognizer.view!.center.x + (velocity.x * slideFactor),
                               y:recognizer.view!.center.y + (velocity.y * slideFactor))
   
      finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
      finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
      
      UIView.animate(withDuration: Double(slideFactor * 2),
                     delay: 0,
        options: UIViewAnimationOptions.curveEaseOut,
        animations: {recognizer.view!.center = finalPoint },
        completion: nil)
    }
    self.chompPlayer?.play()
  }
  
  @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
    if let view = recognizer.view {
      view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
      recognizer.scale = 1
    }
    
  }
  
  @IBAction func handleRotate(recognizer : UIRotationGestureRecognizer) {
    if let view = recognizer.view {
      view.transform = view.transform.rotated(by: recognizer.rotation)
      recognizer.rotation = 0
    }
  }
  
  @objc func handleTap(recognizer: UITapGestureRecognizer) {
    self.chompPlayer?.play()
  }
  
  @objc func handleTickle(recognizer: TickleGestureRecognizer) {
    self.hehePlayer?.play()
  }
}

extension ViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}

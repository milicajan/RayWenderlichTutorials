/**
 Copyright (c) 2016 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

class ViewController: UIViewController {
  
  var chapterNumber = 1
  var book = Book()
  
  // views
  let avatarView = AvatarView()
  let bookTextView = UITextView()
  let chapterLabel = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()

    _ = book.loadChapter(chapterNumber)

    updateViews()   // load the views with book data

    colorViews()    // color views for reference
    addGestures()   // swipe gestures to turn the page
    
    addViews()      // add the sub views to the main view
    setupConstraints()
  }
  
  func setupConstraints() {
    
    bookTextView.translatesAutoresizingMaskIntoConstraints = false
    bookTextView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor).isActive = true
    bookTextView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor).isActive = true
    bookTextView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -20).isActive = true
    bookTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65).isActive = true
    
    avatarView.translatesAutoresizingMaskIntoConstraints = false
    avatarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    avatarView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
    avatarView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    avatarView.bottomAnchor.constraint(equalTo: chapterLabel.topAnchor, constant: -10).isActive = true
    
    chapterLabel.translatesAutoresizingMaskIntoConstraints = false
    chapterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    chapterLabel.bottomAnchor.constraint(equalTo: bookTextView.topAnchor).isActive = true
    chapterLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
    chapterLabel.setContentCompressionResistancePriority( UILayoutPriorityRequired, for: .vertical)
  }
}

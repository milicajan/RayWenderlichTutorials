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

import Foundation

struct Book {
  var textArray: NSArray?
  var chapterImagesArray: NSArray?
  
  var title: String?
  var author: String?
  
  var chapterText: String?
  var chapterImageName: String?
  
  init() {
    guard let plistPath = Bundle.main.path(forResource: "AliceInWonderland",
                          ofType: "plist") else { return }
    guard let dictionary = NSDictionary(contentsOfFile: plistPath) else { return }
    
    textArray = dictionary["Text"] as? NSArray
    chapterImagesArray = dictionary["ChapterImages"] as? NSArray
    
    title = dictionary["Title"] as? String
    author = dictionary["Author"] as? String
  }
  
  mutating func loadChapter(_ chapter: Int) -> Bool {
    
    guard let bookTextArray = textArray else { return false }
    guard let chapterImagesArray = chapterImagesArray else { return false }
    
    guard bookTextArray.count >= chapter && chapter > 0 else { return false }
    chapterText = bookTextArray[chapter-1] as? String
    chapterImageName = chapterImagesArray[chapter-1] as? String
    
    return true
  }
}

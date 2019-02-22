//
//  Download.swift
//  HalfTunes
//
//  Created by Milica Jankovic on 1/2/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import Foundation

class Download {
  
  var track: Track
  init(track: Track) {
    self.track = track
  }
  
  var task: URLSessionDownloadTask?
  var isDownloading = false
  var resumeData: Data?
  
  var progress: Float =  0
}

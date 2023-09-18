//
//  ImageFinder.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 16.09.2023.
//

import UIKit

final class ImageFinder {
  static let shared = ImageFinder()

  private var cacheSet = Set<String>()

  func getImage(with id: String, completion: @escaping (UIImage?) -> Void) {
    assert(Thread.isMainThread)

    if id.hasPrefix("link-") {
      /// The method simulates downloading an image by URL and caching
      if cacheSet.contains(id) {
        completion(UIImage(named: id))
      } else {

        let randomTime = Double.random(in: 0..<1)

        DispatchQueue.main.asyncAfter(deadline: .now() + randomTime) {
          self.cacheSet.insert(id)
          completion(UIImage(named: id))
        }
      }
    } else {
      completion(UIImage(named: id))
    }
  }
}

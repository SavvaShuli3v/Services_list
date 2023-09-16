//
//  UIImage+Extension.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 16.09.2023.
//

import UIKit

extension UIImage {
  static func getImage(with key: String, completion: @escaping (UIImage?) -> Void) {
    assert(Thread.isMainThread)
    ImageFinder.shared.getImage(with: key, completion: completion)
  }
}

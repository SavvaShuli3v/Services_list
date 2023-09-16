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

extension UIImageView {
  func setImage(_ image: UIImage?, animated: Bool = true) {
    let duration = animated ? 0.3 : 0.0
    UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
      self.image = image
    }, completion: nil)
  }
}

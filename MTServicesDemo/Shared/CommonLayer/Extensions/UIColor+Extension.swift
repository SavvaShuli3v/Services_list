//
//  UIColor+Extension.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 17.09.2023.
//

import UIKit

extension UIColor {
  convenience init(lightTheme: UIColor, darkTheme: UIColor) {
    self.init { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .unspecified:
        return lightTheme
      case .light:
        return lightTheme
      case .dark:
        return darkTheme
      @unknown default:
        return lightTheme
      }
    }
  }
}

//
//  UIView+Extension.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 15.09.2023.
//

import UIKit

extension UIView {
  func addSubviews(_ subviews: [UIView]) {
    subviews.forEach { addSubview($0) }
  }
}

//
//  ServicesFactory.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 15.09.2023.
//

import UIKit

struct ServicesFactory {
  func makeViewController() -> ServicesViewController {
      let viewModel = ServicesViewModel()
      return ServicesViewController(viewModel: viewModel)
  }
}

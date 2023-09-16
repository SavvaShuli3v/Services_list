//
//  ServicesFactory.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 15.09.2023.
//

import UIKit

@MainActor
struct ServicesFactory {
  func makeViewController() -> ServicesViewController {
    let viewModel = ServicesViewModel(servicesOperator: ServicesOperator())
      return ServicesViewController(viewModel: viewModel)
  }
}

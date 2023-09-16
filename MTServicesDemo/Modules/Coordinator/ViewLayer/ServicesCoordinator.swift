//
//  ServicesCoordinator.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 16.09.2023.
//

import UIKit

@MainActor
final class ServicesCoordinator {

  weak var navigationController: UINavigationController?

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func showServices() {
    let viewController = ServicesFactory().makeViewController()
    viewController.title = "Московский транспорт"
    navigationController?.pushViewController(
      viewController,
      animated: false
    )
  }
}

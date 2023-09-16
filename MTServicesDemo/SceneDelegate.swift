//
//  SceneDelegate.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 15.09.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: windowScene)
    self.window = window

    let rootNavigationController = UINavigationController()
    window.rootViewController = rootNavigationController
    window.makeKeyAndVisible()

    let coordinator = ServicesCoordinator(navigationController: rootNavigationController)
    coordinator.showServices()
  }
}


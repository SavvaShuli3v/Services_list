//
//  ServicesOperator.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 17.09.2023.
//

import Foundation

struct ServicesOperatorData {
  var isLoading: Bool
  var activatedServices: Set<Service>
  var nonactivatedServices: Set<Service>

  static let `default` = Self(
    isLoading: true,
    activatedServices: [],
    nonactivatedServices: []
  )
}

@MainActor
final class ServicesOperator {
  @Published var state: ServicesOperatorData = .default

  init() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      guard let self else { return }

      self.state.isLoading = false
      self.state.nonactivatedServices = Service.getAllServices()
    }
  }

  func activateService(_ service: Service) {
    state.nonactivatedServices.remove(service)
    state.activatedServices.insert(service)
  }

  func deactivateService(_ service: Service) {
    state.activatedServices.remove(service)
    state.nonactivatedServices.insert(service)
  }
}

enum Service: CaseIterable {
  case scooter
  case carsharing
  case velobike
  case parking
  case facePay
  case taxi
  case poPuti
  case socialTaxi
  case ezs
  case cityShuttle
  case sberShuttle

  fileprivate static func getAllServices() -> Set<Service> {
    var set: Set<Service> = []

    Service.allCases.forEach {
      set.insert($0)
    }

    return set
  }
}

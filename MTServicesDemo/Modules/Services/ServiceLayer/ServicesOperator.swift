//
//  ServicesOperator.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 17.09.2023.
//

import Foundation
import Combine

struct ServicesOperatorModel {
  var isLoading: Bool
  var activatedServices: [Service]
  var nonactivatedServices: [Service]

  static let `default` = Self(
    isLoading: true,
    activatedServices: [],
    nonactivatedServices: []
  )
}

@MainActor
final class ServicesOperator {
  @Published var state: ServicesOperatorModel = .default
  @Published private var servicesStatus: ServicesOperatorData = .default

  private var subscriptions = Set<AnyCancellable>()

  init() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
      guard let self else { return }

      self.state.isLoading = false
      self.state.nonactivatedServices = Service.allCases

      self.$servicesStatus
        .sink { [weak self] data in
          self?.updateState(with: data)
        }
        .store(in: &subscriptions)
    }
  }

  func activateService(_ service: Service) {
    changeStatus(for: service, isActive: true)
  }

  func deactivateService(_ service: Service) {
    changeStatus(for: service, isActive: false)
  }

  private func updateState(with data: ServicesOperatorData) {
    var activatedServices: [Service] = []
    var nonactivatedServices: [Service] = []

    if data.scooterIsActive {
      activatedServices.append(.scooter)
    } else {
      nonactivatedServices.append(.scooter)
    }

    if data.carsharingIsActive {
      activatedServices.append(.carsharing)
    } else {
      nonactivatedServices.append(.carsharing)
    }

    if data.velobikeIsActive {
      activatedServices.append(.velobike)
    } else {
      nonactivatedServices.append(.velobike)
    }

    if data.parkingIsActive {
      activatedServices.append(.parking)
    } else {
      nonactivatedServices.append(.parking)
    }

    if data.facePayIsActive {
      activatedServices.append(.facePay)
    } else {
      nonactivatedServices.append(.facePay)
    }

    if data.taxiIsActive {
      activatedServices.append(.taxi)
    } else {
      nonactivatedServices.append(.taxi)
    }

    if data.poPutiIsActive {
      activatedServices.append(.poPuti)
    } else {
      nonactivatedServices.append(.poPuti)
    }

    if data.socialTaxiIsActive {
      activatedServices.append(.socialTaxi)
    } else {
      nonactivatedServices.append(.socialTaxi)
    }

    if data.ezsIsActive {
      activatedServices.append(.ezs)
    } else {
      nonactivatedServices.append(.ezs)
    }

    if data.cityShuttleIsActive {
      activatedServices.append(.cityShuttle)
    } else {
      nonactivatedServices.append(.cityShuttle)
    }

    if data.sberShuttleIsActive {
      activatedServices.append(.sberShuttle)
    } else {
      nonactivatedServices.append(.sberShuttle)
    }

    self.state.isLoading = false
    self.state.activatedServices = activatedServices
    self.state.nonactivatedServices = nonactivatedServices
  }

  private func changeStatus(for service: Service, isActive: Bool) {
    switch service {
    case .scooter:
      servicesStatus.scooterIsActive = isActive

    case .carsharing:
      servicesStatus.carsharingIsActive = isActive

    case .velobike:
      servicesStatus.velobikeIsActive = isActive

    case .parking:
      servicesStatus.parkingIsActive = isActive

    case .facePay:
      servicesStatus.facePayIsActive = isActive

    case .taxi:
      servicesStatus.taxiIsActive = isActive

    case .poPuti:
      servicesStatus.poPutiIsActive = isActive

    case .socialTaxi:
      servicesStatus.socialTaxiIsActive = isActive

    case .ezs:
      servicesStatus.ezsIsActive = isActive

    case .cityShuttle:
      servicesStatus.cityShuttleIsActive = isActive

    case .sberShuttle:
      servicesStatus.sberShuttleIsActive = isActive
    }
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
}

private struct ServicesOperatorData {
  var scooterIsActive: Bool
  var carsharingIsActive: Bool
  var velobikeIsActive: Bool
  var parkingIsActive: Bool
  var facePayIsActive: Bool
  var taxiIsActive: Bool
  var poPutiIsActive: Bool
  var socialTaxiIsActive: Bool
  var ezsIsActive: Bool
  var cityShuttleIsActive: Bool
  var sberShuttleIsActive: Bool

  static let `default` = Self(
    scooterIsActive: false,
    carsharingIsActive: false,
    velobikeIsActive: false,
    parkingIsActive: false,
    facePayIsActive: false,
    taxiIsActive: false,
    poPutiIsActive: false,
    socialTaxiIsActive: false,
    ezsIsActive: false,
    cityShuttleIsActive: false,
    sberShuttleIsActive: false
  )
}

//
//  ServicesViewModel.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 15.09.2023.
//

import Combine

@MainActor
final class ServicesViewModel {
  @Published var state: ServicesViewState = .default

  private let servicesOperator: ServicesOperator

  private var subscriptions = Set<AnyCancellable>()

  init(servicesOperator: ServicesOperator) {
    self.servicesOperator = servicesOperator
  }

}

extension ServicesViewModel {
  func viewDidLoad() {
    servicesOperator.$state
      .sink { [weak self] state in
        guard let self else { return }

        guard !state.isLoading else {
          self.state.isLoading = true
          return
        }

        self.state.isLoading = false
        self.state.activatedServices = state.activatedServices.map { $0.activatedServiceCellModel }
        self.state.nonactivatedServices = state.nonactivatedServices.map { $0.nonactivatedServiceCellModel }
      }
      .store(in: &subscriptions)
  }

  func didTapToActivatedService(with model: ActivatedServiceCellModel) {
    servicesOperator.deactivateService(model.service)
  }

  func didTapToNonactivatedService(with model: NonactivatedServiceCellModel) {
    servicesOperator.activateService(model.service)
  }
}

// MARK: - Data

import UIKit

extension Service {
  var nonactivatedServiceCellModel: NonactivatedServiceCellModel {
    switch self {
    case .scooter:
      return NonactivatedServiceCellModel(
        service: self,
        title: "Аренда самокатов",
        titleColor: .white,
        color: UIColor(red: 0.353, green: 0.8, blue: 0.694, alpha: 1),
        imageId: "link-BigScooter"
      )

    case .carsharing:
      return NonactivatedServiceCellModel(
        service: self,
        title: "Аренда автомобилей",
        titleColor: .white,
        color: UIColor(red: 0.979, green: 0.556, blue: 0.249, alpha: 1),
        imageId: "link-BigCarsharing"
      )

    case .velobike:
      return   NonactivatedServiceCellModel(
        service: self,
        title: "Велобайк",
        titleColor: .white,
        color: UIColor(red: 0.439, green: 0.714, blue: 0.431, alpha: 1),
        imageId: "link-BigVelobike"
      )

    case .parking:
      return NonactivatedServiceCellModel(
        service: self,
        title: "Парковки",
        titleColor: .white,
        color: UIColor(red: 0.102, green: 0.4, blue: 0.8, alpha: 1),
        imageId: "link-BigParking"
      )

    case .facePay:
      return NonactivatedServiceCellModel(
        service: self,
        title: "Оплата по биометрии",
        titleColor: .white,
        color: UIColor(red: 0.855, green: 0.125, blue: 0.196, alpha: 1),
        imageId: "link-BigFacePay"
      )

    case .taxi:
      return NonactivatedServiceCellModel(
        service: self,
        title: "Такси",
        titleColor: .black,
        color: UIColor(red: 1, green: 0.8, blue: 0.227, alpha: 1),
        imageId: "link-BigTaxi"
      )

    case .poPuti:
      return NonactivatedServiceCellModel(
        service: self,
        title: "Заказ автобуса",
        titleColor: .white,
        color: UIColor(red: 0, green: 0.325, blue: 0.706, alpha: 1),
        imageId: "link-BigPoPuti"
      )

    case .socialTaxi:
      return NonactivatedServiceCellModel(
        service: self,
        title: "Социальное такси",
        titleColor: .white,
        color: UIColor(red: 0, green: 0.325, blue: 0.706, alpha: 1),
        imageId: "link-SocialTaxi"
      )

    case .ezs:
      return NonactivatedServiceCellModel(
        service: self,
        title: "Электрозарядные станции",
        titleColor: .white,
        color: UIColor(red: 0.851, green: 0.192, blue: 0.529, alpha: 1),
        imageId: "link-BigEZS"
      )

    case .cityShuttle:
      return NonactivatedServiceCellModel(
        service: self,
        title: "Шаттлы в Москва-сити",
        titleColor: .white,
        color: UIColor(red: 0.353, green: 0.063, blue: 0.635, alpha: 1),
        imageId: "link-BigCityShuttle"
      )

    case .sberShuttle:
      return NonactivatedServiceCellModel(
        service: self,
        title: "Сбер–Шаттл",
        titleColor: .white,
        color: UIColor(red: 0.149, green: 0.533, blue: 0.418, alpha: 1),
        imageId: "link-BigSberShuttle"
      )
    }
  }

  var activatedServiceCellModel: ActivatedServiceCellModel {
    switch self {
    case .scooter:
      return ActivatedServiceCellModel(
        service: self,
        title: "Аренда самокатов",
        imageId: "link-IconScooter"
      )

    case .carsharing:
      return ActivatedServiceCellModel(
        service: self,
        title: "Аренда автомобилей",
        imageId: "link-IconCarsharing"
      )

    case .velobike:
      return ActivatedServiceCellModel(
        service: self,
        title: "Велобайк",
        imageId: "link-IconVelobike"
      )

    case .parking:
      return ActivatedServiceCellModel(
        service: self,
        title: "Парковки",
        imageId: "link-IconParking"
      )

    case .facePay:
      return ActivatedServiceCellModel(
        service: self,
        title: "Оплата по биометрии",
        imageId: "link-IconFacepay"
      )

    case .taxi:
      return ActivatedServiceCellModel(
        service: self,
        title: "Такси",
        imageId: "link-IconTaxi"
      )

    case .poPuti:
      return ActivatedServiceCellModel(
        service: self,
        title: "Заказ автобуса",
        imageId: "link-IconPoPuti"
      )

    case .socialTaxi:
      return ActivatedServiceCellModel(
        service: self,
        title: "Социальное такси",
        imageId: "link-IconPoPuti"
      )

    case .ezs:
      return ActivatedServiceCellModel(
        service: self,
        title: "Электрозарядные станции",
        imageId: "link-IconEZS"
      )

    case .cityShuttle:
      return ActivatedServiceCellModel(
        service: self,
        title: "Шаттлы в Москва-сити",
        imageId: "link-IconCityShuttle"
      )

    case .sberShuttle:
      return ActivatedServiceCellModel(
        service: self,
        title: "Сбер–Шаттл",
        imageId: "link-IconSberShuttle"
      )

    }
  }
}

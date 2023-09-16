//
//  ServicesViewModel.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 15.09.2023.
//

import UIKit

@MainActor
final class ServicesViewModel {
  @Published var state: ServicesViewState = .default

  nonisolated init() {}

}

extension ServicesViewModel {
  func viewDidLoad() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
      guard let self else { return }
      self.state.isLoading = false
      self.state.activatedServices = []
      self.state.nonactivatedServices = Service.allCases.map { $0.nonactivatedServiceCellModel }
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
      self?.state.activatedServices = [Service.carsharing.activatedServiceCellModel]
      self?.state.nonactivatedServices.remove(at: 1)
    }
  }
}

// MARK: - Test Data

private let nonactivatedServices_1: [NonactivatedServiceCellModel] = [

]

// MARK: - Data

private enum Service: CaseIterable {
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

  var nonactivatedServiceCellModel: NonactivatedServiceCellModel {
    switch self {
    case .scooter:
      return NonactivatedServiceCellModel(
        serviceId: "",
        title: "Аренда самокатов",
        titleColor: .white,
        color: UIColor(red: 0.353, green: 0.8, blue: 0.694, alpha: 1),
        imageId: "link-BigScooter"
      )

    case .carsharing:
      return NonactivatedServiceCellModel(
        serviceId: "",
        title: "Аренда автомобилей",
        titleColor: .white,
        color: UIColor(red: 0.979, green: 0.556, blue: 0.249, alpha: 1),
        imageId: "link-BigCarsharing"
      )

    case .velobike:
      return   NonactivatedServiceCellModel(
        serviceId: "",
        title: "Велобайк",
        titleColor: .white,
        color: UIColor(red: 0.439, green: 0.714, blue: 0.431, alpha: 1),
        imageId: "link-BigVelobike"
      )

    case .parking:
      return NonactivatedServiceCellModel(
        serviceId: "",
        title: "Парковки",
        titleColor: .white,
        color: UIColor(red: 0.102, green: 0.4, blue: 0.8, alpha: 1),
        imageId: "link-BigParking"
      )

    case .facePay:
      return NonactivatedServiceCellModel(
        serviceId: "",
        title: "Оплата по биометрии",
        titleColor: .white,
        color: UIColor(red: 0.855, green: 0.125, blue: 0.196, alpha: 1),
        imageId: "link-BigFacePay"
      )

    case .taxi:
      return NonactivatedServiceCellModel(
        serviceId: "",
        title: "Такси",
        titleColor: .black,
        color: UIColor(red: 1, green: 0.8, blue: 0.227, alpha: 1),
        imageId: "link-BigTaxi"
      )

    case .poPuti:
      return NonactivatedServiceCellModel(
        serviceId: "",
        title: "Заказ автобуса",
        titleColor: .white,
        color: UIColor(red: 0, green: 0.325, blue: 0.706, alpha: 1),
        imageId: "link-SocialTaxi"
      )

    case .socialTaxi:
      return NonactivatedServiceCellModel(
        serviceId: "",
        title: "Заказ автобуса",
        titleColor: .white,
        color: UIColor(red: 0, green: 0.325, blue: 0.706, alpha: 1),
        imageId: "link-BigPoPuti"
      )

    case .ezs:
      return NonactivatedServiceCellModel(
        serviceId: "",
        title: "Электрозарядные станции",
        titleColor: .white,
        color: UIColor(red: 0.851, green: 0.192, blue: 0.529, alpha: 1),
        imageId: "link-BigEZS"
      )

    case .cityShuttle:
      return NonactivatedServiceCellModel(
        serviceId: "",
        title: "Шаттлы в Москва-сити",
        titleColor: .white,
        color: UIColor(red: 0.353, green: 0.063, blue: 0.635, alpha: 1),
        imageId: "link-BigCityShuttle"
      )

    case .sberShuttle:
      return NonactivatedServiceCellModel(
        serviceId: "",
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
        serviceId: "",
        title: "Аренда самокатов",
        imageId: "link-IconScooter"
      )

    case .carsharing:
      return ActivatedServiceCellModel(
        serviceId: "",
        title: "Аренда автомобилей",
        imageId: "link-IconCarsharing"
      )

    case .velobike:
      return ActivatedServiceCellModel(
        serviceId: "",
        title: "Велобайк",
        imageId: "link-IconVelobike"
      )

    case .parking:
      return ActivatedServiceCellModel(
        serviceId: "",
        title: "Парковки",
        imageId: "link-IconParking"
      )

    case .facePay:
      return ActivatedServiceCellModel(
        serviceId: "",
        title: "Оплата по биометрии",
        imageId: ""
      )

    case .taxi:
      return ActivatedServiceCellModel(
        serviceId: "",
        title: "Такси",
        imageId: "link-IconFacepay"
      )

    case .poPuti:
      return ActivatedServiceCellModel(
        serviceId: "",
        title: "Заказ автобуса",
        imageId: ""
      )

    case .socialTaxi:
      return ActivatedServiceCellModel(
        serviceId: "",
        title: "Заказ автобуса",
        imageId: "link-IconPoPuti"
      )

    case .ezs:
      return ActivatedServiceCellModel(
        serviceId: "",
        title: "Электрозарядные станции",
        imageId: "link-IconEZS"
      )

    case .cityShuttle:
      return ActivatedServiceCellModel(
        serviceId: "",
        title: "Шаттлы в Москва-сити",
        imageId: "link-IconCityShuttle"
      )

    case .sberShuttle:
      return ActivatedServiceCellModel(
        serviceId: "",
        title: "Сбер–Шаттл",
        imageId: "link-IconSberShuttle"
      )

    }
  }
}

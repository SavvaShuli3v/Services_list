//
//  ServicesViewState.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 15.09.2023.
//

import Foundation

struct ServicesViewState {
  var activatedServices: [ActivatedServiceCellModel]
  var nonactivatedServices: [NonactivatedServiceCellModel]
  var isUpdating: Bool
  var isLoading: Bool

  static let `default` = Self(
    activatedServices: [],
    nonactivatedServices: [],
    isUpdating: false,
    isLoading: true
  )
}

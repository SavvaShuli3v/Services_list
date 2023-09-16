//
//  ServicesCollectionView.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 15.09.2023.
//

import UIKit

struct ActivatedServiceCellModel: Hashable {
  let serviceId: String
  let title: String
  let imageId: String
}

struct NonactivatedServiceCellModel: Hashable {
  let serviceId: String
  let title: String
  let titleColor: UIColor
  let color: UIColor
  let imageId: String
}

final class ServicesCollectionView: UICollectionView {

  var model: ServicesViewState = .default {
    didSet {
      apply()
    }
  }

  // MARK: - UICollectionViewDiffableDataSource

  private enum ServicesSection: Int {
    case activatedServices
    case nonactivatedServices
  }

  private enum ServiceItem: Hashable {
    case activatedService(ActivatedServiceCellModel)
    case nonactivatedService(NonactivatedServiceCellModel)

    init(nonactivatedServiceModel: NonactivatedServiceCellModel) {
      self = .nonactivatedService(nonactivatedServiceModel)
    }

    init(activatedServiceModel: ActivatedServiceCellModel) {
      self = .activatedService(activatedServiceModel)
    }
  }

  private lazy var diffableDataSource = UICollectionViewDiffableDataSource<ServicesSection, ServiceItem>(
    collectionView: self,
    cellProvider: cellProvider
  )

  private lazy var cellProvider: UICollectionViewDiffableDataSource<ServicesSection, ServiceItem>.CellProvider = { [weak self] tableView, indexPath, itemIdentifier in
    guard let self else { return UICollectionViewCell() }

    switch itemIdentifier {
    case .activatedService(let model):
      let cell = dequeueReusableCell(withReuseIdentifier: lineCellId, for: indexPath) as! ServiceLineCollectionViewCell
      cell.model = model
      return cell
      
    case .nonactivatedService(let model):
      let cell = dequeueReusableCell(withReuseIdentifier: boxCellId, for: indexPath) as! ServiceBoxCollectionViewCell
      cell.model = model
      return cell
    }
  }

  private let estimatedWidth = 160.0
  private let cellMarginSize = 16.0
  private let headerId = "headerId"
  private let boxCellId = "boxCellId"
  private let lineCellId = "lineCellId"

  override var intrinsicContentSize: CGSize {
    return collectionViewLayout.collectionViewContentSize
  }

  // MARK: - Init

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    let flowLayout = ColumnCalculatedFlowLayout()
    flowLayout.itemSize = CGSize(width: 100, height: 100)
    flowLayout.minimumLineSpacing = CGFloat(cellMarginSize)
    flowLayout.minimumInteritemSpacing = CGFloat(cellMarginSize)
    super.init(frame: .zero, collectionViewLayout: flowLayout)
    register(ServicesCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    register(ServiceBoxCollectionViewCell.self, forCellWithReuseIdentifier: boxCellId)
    register(ServiceLineCollectionViewCell.self, forCellWithReuseIdentifier: lineCellId)
    configureHeaders()
    delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Apply

  func apply() {
    var snapshot = NSDiffableDataSourceSnapshot<ServicesSection, ServiceItem>()

    if model.activatedServices.isEmpty {
      snapshot.deleteSections([.activatedServices])
    } else {
      snapshot.appendSections([.activatedServices])
      let serviceItems = model.activatedServices.map {
        ServiceItem(activatedServiceModel: $0)
      }
      snapshot.appendItems(serviceItems, toSection: .activatedServices)
    }

    if model.nonactivatedServices.isEmpty {
      snapshot.deleteSections([.nonactivatedServices])
    } else {
      snapshot.appendSections([.nonactivatedServices])
      let serviceItems = model.nonactivatedServices.map {
        ServiceItem(nonactivatedServiceModel: $0)
      }
      snapshot.appendItems(serviceItems, toSection: .nonactivatedServices)
    }

    diffableDataSource.apply(snapshot, animatingDifferences: true)
  }

//  override func layoutSubviews() {
//    super.layoutSubviews()
//    self.setupFlowLayout()
//    if self.bounds.size != self.intrinsicContentSize {
//      self.invalidateIntrinsicContentSize()
//    }
//  }

  func configureHeaders() {
    diffableDataSource.supplementaryViewProvider = { [weak self] (
      collectionView: UICollectionView,
      kind: String,
      indexPath: IndexPath
    ) -> UICollectionReusableView? in
      guard let self else { return nil }

      let header = self.dequeueReusableSupplementaryView(
        ofKind: UICollectionView.elementKindSectionHeader,
        withReuseIdentifier: self.headerId,
        for: indexPath
      ) as! ServicesCollectionViewHeader

      guard let section = diffableDataSource.sectionIdentifier(for: indexPath.section) else { return nil }

      switch section {
      case .activatedServices:
        header.titleLabel.text = "Активные сервисы"

      case .nonactivatedServices:
        header.titleLabel.text = "Все сервисы"
      }

      return header
    }
  }

}

// MARK: - UICollectionViewDelegate

extension ServicesCollectionView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let _ = diffableDataSource.itemIdentifier(for: indexPath) else { return }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ServicesCollectionView: UICollectionViewDelegateFlowLayout {

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    guard let section = diffableDataSource.sectionIdentifier(for: indexPath.section) else { return .zero }

    switch section {
    case .activatedServices:
      return CGSize(width: bounds.width, height: 56)

    case .nonactivatedServices:
      let width = self.calculateWidth()
      return CGSize(width: width, height: width)
    }
  }

  func calculateWidth() -> CGFloat {
    let estimatedWidth = CGFloat(estimatedWidth)
    let cellCount = floor(CGFloat(frame.size.width) / estimatedWidth)

    let margine = CGFloat(cellMarginSize * 2)
    let width = (frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margine) / cellCount

    return width
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    guard let section = diffableDataSource.sectionIdentifier(for: section) else { return .zero }

    switch section {
    case .activatedServices:
      return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)

    case .nonactivatedServices:
      return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: bounds.width, height: 80)
  }
  
}

// MARK: - ColumnCalculatedFlowLayout

private class ColumnCalculatedFlowLayout: UICollectionViewFlowLayout {

  override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
    guard
      let context = super.invalidationContext(forBoundsChange: newBounds) as? UICollectionViewFlowLayoutInvalidationContext
    else {
      return UICollectionViewLayoutInvalidationContext()
    }

    context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
    return context
  }
}

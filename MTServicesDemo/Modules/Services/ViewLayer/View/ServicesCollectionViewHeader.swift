//
//  ServicesCollectionViewHeader.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 17.09.2023.
//

import UIKit
import SnapKit

final class ServicesCollectionViewHeader: UICollectionReusableView {

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 24, weight: .medium)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ServicesCollectionViewHeader {
  private func setupUI() {
    setupHierarchy()
    layout()
  }

  private func setupHierarchy() {
    addSubviews([titleLabel])
  }

  private func layout() {
    titleLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
  }
}

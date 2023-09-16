//
//  ServiceLineCollectionViewCell.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 16.09.2023.
//

import UIKit
import SnapKit

final class ServiceLineCollectionViewCell: UICollectionViewCell {
  var model: ActivatedServiceCellModel? {
    didSet {
      updateUI()
    }
  }

  private lazy var lineView: UIView = {
    let view = UIView()
    view.backgroundColor =  UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
    return view
  }()

  private lazy var imageView = UIImageView()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18, weight: .medium)
    return label
  }()

  private lazy var chevron: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func updateUI() {
    guard let model else {
      imageView.image = nil
      titleLabel.text = nil
      return
    }

    titleLabel.text = model.title
    UIImage.getImage(with: model.imageId) { [weak self] image in
      guard
        let self,
        let image,
        let currentModel = self.model,
        currentModel.imageId == model.imageId
      else { return }

      self.imageView.image = image
    }
  }

}

extension ServiceLineCollectionViewCell {
  private func setupUI() {
    setupHierarchy()
    layout()

    UIImage.getImage(with: Images.Names.chevron) { [weak self] image in
      self?.chevron.image = image
    }
  }

  private func setupHierarchy() {
    addSubviews([lineView, imageView, titleLabel, chevron])
  }

  private func layout() {
    lineView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.height.equalTo(1)
    }

    imageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(16)
      $0.width.height.equalTo(32)
    }

    titleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(60)
    }

    chevron.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-16)
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(24)
    }
  }
}

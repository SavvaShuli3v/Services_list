//
//  ServiceBoxCollectionViewCell.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 15.09.2023.
//

import UIKit
import SnapKit

final class ServiceBoxCollectionViewCell: UICollectionViewCell {
  var model: NonactivatedServiceCellModel? {
    didSet {
      updateUI()
    }
  }

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .clear
    label.font = .systemFont(ofSize: 18, weight: .medium)
    return label
  }()

  override var isHighlighted: Bool {
    didSet {
      UIView.animate(
        withDuration: 0.15,
        delay: !isHighlighted ? 0.15 : 0.0,
        options: .allowUserInteraction,
        animations: {
          self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.90, y: 0.90) : CGAffineTransform.identity
        },
        completion: nil
      )
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.imageView.image = nil
    self.titleLabel.text = nil
    self.titleLabel.textColor = nil
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let imageHeight = bounds.height / 1.5
    let imageSize = CGSize(
      width: imageHeight * 1.2,
      height: imageHeight
    )

    imageView.frame = CGRect(
      origin: CGPoint(x: bounds.width - imageSize.width, y: bounds.height - imageSize.height),
      size: imageSize
    )
  }

  private func updateUI() {
    guard let model else {
      titleLabel.text = nil
      titleLabel.textColor = .clear
      backgroundColor = .clear
      imageView.image = nil
      return
    }
    titleLabel.text = model.title
    titleLabel.textColor = model.titleColor
    backgroundColor = model.color
    UIImage.getImage(with: model.imageId) { [weak self] image in
      guard
        let self,
        let currentModel = self.model
      else { return }

      self.imageView.setImage(image)
    }
  }

}

extension ServiceBoxCollectionViewCell {
  private func setupUI() {
    layer.cornerRadius = 22
    clipsToBounds = true
    setupHierarchy()
    layout()
  }

  private func setupHierarchy() {
    addSubviews([imageView, titleLabel])
  }

  private func layout() {
    titleLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(16)
    }
  }
}

//
//  ServicesViewController.swift
//  MTServicesDemo
//
//  Created by Savva Shuliatev on 15.09.2023.
//

import UIKit
import SnapKit
import Combine

final class ServicesViewController: UIViewController {

  private let viewModel: ServicesViewModel

  private lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.style = .large
    return activityIndicator
  }()
  private lazy var collectionView = ServicesCollectionView()

  private var subscriptions = Set<AnyCancellable>()

  // MARK: - Init

  init(viewModel: ServicesViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.$state
      .sink { [weak self] viewState in
        guard let self else { return }

        self.collectionView.model = viewState

        if viewState.isLoading {
          self.activityIndicator.startAnimating()
        } else {
          self.activityIndicator.stopAnimating()
        }
      }
      .store(in: &subscriptions)

    setupUI()
    viewModel.viewDidLoad()
  }

}

// MARK: - Setup UI

extension ServicesViewController {
  private func setupUI() {
    view.backgroundColor = UIColor(lightTheme: .white, darkTheme: .black) 
    setupHierarchy()
    layout()
  }

  private func setupHierarchy() {
    view.addSubviews([collectionView, activityIndicator])
  }

  private func layout() {
    collectionView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
    }

    activityIndicator.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
}

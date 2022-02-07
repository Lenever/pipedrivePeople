//
//  PersonDetailViewController.swift
//  PipedrivePeoples
//
//  Created by Ikechukwu Onuorah on 02/02/2022.
//

import UIKit

class PersonDetailViewController: UIViewController {
  private var viewModel = PersonDetailViewModel()

  private var personId: Int? {
    didSet {
      if let personId = personId {
        loadPersonDetail(personId: personId)
      }
    }
  }
  
  private var personDetail: Person? {
    didSet {
      guard let detail = personDetail else { return }
      DispatchQueue.main.async {
        self.titleLabel.text = detail.name
        self.sourceLabel.text = detail.phone?[0].value
        self.ratingLabel.text = detail.email?[0].value
      }
    }
  }

  private var titleLabel = UILabel()
  private var sourceLabel = UILabel()
  private var ratingLabel = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    layoutSubviews()
    loadPersonDetail(personId: personId ?? Int())
  }

  func layoutSubviews() {
    setupNavigationBar()
    setuptitleLabel()
    setupSourceLabel()
    setupRatingLabel()
  }

  func setupNavigationBar() {
    navigationController?.navigationBar.isTranslucent = true
    navigationItem.title = Constants.detailHeader
  }

  func setuptitleLabel() {
    view.addSubview(titleLabel)
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .byWordWrapping
    titleLabel.textAlignment = .center

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Padding.largest).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.horizontal).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.horizontal).isActive = true
  }

  func setupSourceLabel() {
    view.addSubview(sourceLabel)
    sourceLabel.numberOfLines = 0
    sourceLabel.lineBreakMode = .byWordWrapping
    sourceLabel.textAlignment = .center

    sourceLabel.translatesAutoresizingMaskIntoConstraints = false
    sourceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Padding.horizontal).isActive = true
    sourceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.horizontal).isActive = true
    sourceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.horizontal).isActive = true
  }

  func setupRatingLabel() {
    view.addSubview(ratingLabel)
    ratingLabel.numberOfLines = 0
    ratingLabel.lineBreakMode = .byWordWrapping
    ratingLabel.textAlignment = .center

    ratingLabel.translatesAutoresizingMaskIntoConstraints = false
    ratingLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: Padding.large).isActive = true
    ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.horizontal).isActive = true
    ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.horizontal).isActive = true
  }

  func loadPersonDetail(personId: Int) {
    viewModel.fetchPersonDetail(
      personId: personId,
      success: { personDetail in
        self.personDetail = personDetail
      },
      failure: { error in
        DispatchQueue.main.async {
          self.handleNetworkError(prompt: error)
        }
      }
    )
  }

  init(personDetail: Person) {
    self.personDetail = personDetail
    self.personId = personDetail.id
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

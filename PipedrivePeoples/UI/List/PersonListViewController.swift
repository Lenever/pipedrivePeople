//
//  PersonListViewController.swift
//  PipedrivePeoples
//
//  Created by Ikechukwu Onuorah on 02/02/2022.
//

import UIKit

class PersonListViewController: UIViewController {
  private var viewModel = PersonListViewModel()

  var personListTableView = UITableView()
  var personList = [Person]()

  override func viewDidLoad() {
    super.viewDidLoad()
    layoutSubviews()
  }

  override func viewDidAppear(_ animated: Bool) {
    loadPersonList()
  }

  func layoutSubviews() {
    navigationBar()
    setupPersonListTableView()
    self.personListTableView.tableFooterView = UIView()
  }

  func setupPersonListTableView() {
    let headerView: UIView = UIView.init(frame: CGRect.init(x: 1, y: 50, width: view.frame.width, height: 30))
    let labelView: UILabel = UILabel.init(frame: CGRect.init(x: 4, y: 5, width: view.frame.width, height: 24))
    labelView.text = Constants.listHeader
    labelView.textAlignment = .center

    headerView.addSubview(labelView)
    personListTableView.tableHeaderView = headerView

    view.addSubview(personListTableView)
    personListTableView.delegate = self
    personListTableView.dataSource = self

    personListTableView.translatesAutoresizingMaskIntoConstraints = false
    personListTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    personListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    personListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    personListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }

  func loadPersonList() {
    viewModel.fetchPersonList(
      success: { personList in
        self.personList = personList
        DispatchQueue.main.async {
          self.personListTableView.reloadData()
        }
      },
      failure: { error in
        DispatchQueue.main.async {
          self.handleNetworkError(prompt: error)
        }
      }
    )
  }

  func navigationBar() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.view.backgroundColor = .clear
    self.navigationController?.navigationBar.barStyle = .black
  }
}

extension PersonListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return personList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = personList[indexPath.row].name
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let personDetail = personList[indexPath.row]
    let viewController = PersonDetailViewController(personDetail: personDetail)

    self.navigationController?.pushViewController(viewController, animated: true)
  }
}

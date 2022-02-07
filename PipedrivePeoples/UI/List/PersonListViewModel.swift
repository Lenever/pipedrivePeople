//
//  PersonListViewModel.swift
//  PipedrivePeoples
//
//  Created by Ikechukwu Onuorah on 05/02/2022.
//

import Foundation

final class PersonListViewModel {
  var repository: RemoteRepository?

  func fetchPersonList(success: @escaping ([Person]) -> (), failure: @escaping (String) -> ()) {
    repository?.getPersons(
      success: {(personList: [Person]) in
        success(personList)
      },
      failure: { (error) in
        failure(error)
      }
    )
  }
  
  init() {
    self.repository = RemoteRepository()
  }
}

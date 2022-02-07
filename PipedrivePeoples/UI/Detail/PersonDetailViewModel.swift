//
//  PersonDetailViewModel.swift
//  PipedrivePeoples
//
//  Created by Ikechukwu Onuorah on 05/02/2022.
//

class PersonDetailViewModel {
  var repository: RemoteRepository?
  
  init() {
    self.repository = RemoteRepository()
  }
  
  func fetchPersonDetail(personId: Int, success: @escaping (Person) -> (), failure: @escaping (String) -> ()) {
    repository?.getPersonDetail(
      personId: personId,
      success: {gifInfo in
        success(gifInfo)
      },
      failure: {error in
        failure(error)
      }
    )
  }
}

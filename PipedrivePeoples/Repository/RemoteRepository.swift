//
//  RemoteRepository.swift
//  PipedrivePeoples
//
//  Created by Ikechukwu Onuorah on 03/02/2022.
//

import Foundation

struct RemoteRepository {
  private var client = APIClient()
  
  func getPersons(success: @escaping ([Person]) -> (), failure: @escaping (String) -> ()) {

    NetworkManager.shared.isConnectedToNetwork() {(isConnected) in
      if isConnected {
        print("Internet Connection Available!")
        client.request(
          endpointType: .persons,
          success:  {(response: APIPersonListResponse) in
            if let personList = response.data {

              LocalStorageManager.shared.removeObject(forKey: "listObject")

              LocalStorageManager.shared.saveObject(forKey: "listObject", object: response)

              success(personList)
            } else {
              failure("Value does not exist")
            }
          },
          failure: { (error) in
            failure(error)
          }
        )
      }else{
        if let savedData = LocalStorageManager.shared.getObject(forkey: "listObject", objectType: APIPersonListResponse.self),
           let savePersonList = savedData.data {
          success(savePersonList)
        }
        failure("Internet Connection not Available!")
      }
    }
  }
  
  func getPersonDetail(personId: Int, success: @escaping (Person) -> (), failure: @escaping (String) -> ()) {
    client.request(
      endpointType: .personId(personId),
      success: {(response: APIPersonDetailResponse) in
        if let personDetail = response.data {
          success(personDetail)
        }
      },
      failure: {error in
        failure(error)
      }
    )
  }
}

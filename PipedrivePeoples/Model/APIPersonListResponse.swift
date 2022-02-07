//
//  APIPersonListResponse.swift
//  PipedrivePeoples
//
//  Created by Ikechukwu Onuorah on 03/02/2022.
//

import Foundation

// MARK: - APIPersonListResponse
struct APIPersonListResponse: Codable {
  let success: Bool?
  let data: [Person]?
}

// MARK: - Person
struct Person: Codable {
  let id: Int?
  let name: String?
  let phone: [PhoneDetail]?
  let email: [EmailDetail]?
}

// MARK: - EmailDetail
struct PhoneDetail: Codable {
  let value: String?
  let primary: Bool?
  let label: String?
}

// MARK: - EmailDetail
struct EmailDetail: Codable {
  let value: String?
  let primary: Bool?
  let label: String?
}

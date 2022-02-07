//
//  APIPersonDetailResponse.swift
//  PipedrivePeoples
//
//  Created by Ikechukwu Onuorah on 03/02/2022.
//

import Foundation

// MARK: - APIPersonDetailResponse
struct APIPersonDetailResponse: Codable {
  let success: Bool?
  let data: Person?
}

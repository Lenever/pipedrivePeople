//
//  APIClient.swift
//  PipedrivePeoples
//
//  Created by Ikechukwu Onuorah on 02/02/2022.
//

import UIKit

struct APIClient {
  // TODO: Implement
  var urlSession = URLSession.shared
  var baseUrl = Constants.baseUrl
  
  enum HttpMethodType: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
    case put = "PUT"
  }
  
  enum EndPointType {
    case personId(Int)
    case persons
    
    var value: Int {
      switch self {
      case .persons:
        return Int()
      case .personId(let id):
        return id
      }
    }
  }
  
  func request <ResponseBody: Decodable> (requestType: HttpMethodType = .get, endpointType: EndPointType, params: [String: Any] = [:], success: @escaping (ResponseBody) -> (), failure: @escaping (String) -> ()) {
    
    var components = URLComponents()
    switch endpointType {
    case .personId:
      components = URLComponents(string: "\(baseUrl)/\(endpointType.value)")!
    case .persons:
      components = URLComponents(string: "\(baseUrl)")!
    }
    
    var parameters = params
    
    parameters["api_token"] = Constants.apiToken
    
    components.queryItems = parameters.map { (key, value) in
      URLQueryItem(name: key, value: value as? String)
    }
    
    components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    
    var request = URLRequest(url: components.url!)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = requestType.rawValue
    
    let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error with fetching data: \(error)")
        failure(error.localizedDescription)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
              print("Error with the response, unexpected status code: \(response ?? URLResponse())")
              failure(response.debugDescription)
              return
            }
      
      if let data = data,
         let result = try? JSONDecoder().decode(ResponseBody.self, from: data) {
        success(result)
      }
    })
    task.resume()
  }
}

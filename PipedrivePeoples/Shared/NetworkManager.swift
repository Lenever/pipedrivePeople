//
//  NetworkManager.swift
//  PipedrivePeoples
//
//  Created by Ikechukwu Onuorah on 06/02/2022.
//

import Network

public class NetworkManager {
  static let shared = NetworkManager()
  let monitor = NWPathMonitor()

  func isConnectedToNetwork(completion: @escaping (Bool) -> ()) {
    monitor.pathUpdateHandler = { path in
      if path.status == .satisfied {
        print("We're connected!")
        completion(true)
      } else {
        print("No connection.")
        completion(false)
      }

      print(path.isExpensive)
    }

    let queue = DispatchQueue(label: "Monitor")
    monitor.start(queue: queue)
  }
}


//
//  LocalStorageManager.swift
//  PipedrivePeoples
//
//  Created by Ikechukwu Onuorah on 06/02/2022.
//

import Foundation

class LocalStorageManager {
  static let shared = LocalStorageManager()

  public func saveObject<Object: Encodable> (forKey: String, object: Object) {
        do {

            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(object)
            let json = String(data: jsonData, encoding: .utf8) ?? "{}"

            let defaults: UserDefaults = UserDefaults.standard
            defaults.set(json, forKey: forKey)
            defaults.synchronize()

        } catch {
            print(error.localizedDescription)
        }
    }

  public func getObject<Object: Decodable>(forkey: String, objectType: Object.Type) -> Object? {
        do {
            if (UserDefaults.standard.object(forKey: forkey) == nil) {
                return nil
            } else {
                let json = UserDefaults.standard.string(forKey: forkey) ?? "{}"

                let jsonDecoder = JSONDecoder()
                guard let jsonData = json.data(using: .utf8) else {
                    return nil
                }

                let object: Object = try jsonDecoder.decode(objectType.self, from: jsonData)
                return object
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

  public func removeObject(forKey: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: forKey)
        defaults.synchronize()
    }
}

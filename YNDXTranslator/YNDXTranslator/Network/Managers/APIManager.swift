//
//  APIManager.swift
//  YNDXTranslator
//
//  Created by Egor on 24/01/2021.
//  Copyright © 2021 Egor. All rights reserved.
//

import Foundation
protocol IAPIManager {
    func sendRequest<T: Codable>(request: URLRequest, with text: String, completion: @escaping (T?) -> Void)
}
class APIManager: IAPIManager {
    func sendRequest<T: Codable>(request: URLRequest, with text: String, completion: @escaping (T?) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            print(Thread.current)
            if error != nil {
                completion(nil)
            }
            guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                print(Thread.current)
                completion(model)
            }
        }.resume()
    }
}

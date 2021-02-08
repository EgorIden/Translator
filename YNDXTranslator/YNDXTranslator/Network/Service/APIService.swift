//
//  APIService.swift
//  YNDXTranslator
//
//  Created by Egor on 25/01/2021.
//  Copyright © 2021 Egor. All rights reserved.
//

import Foundation
protocol IAPIService {
    func getTranslate(with text: String, from: Languages, to: Languages, completion: @escaping (Translation?) -> Void) -> Void
}
class APIService: IAPIService {
    private let apiManager = APIManager()
    func getTranslate(with text: String, from: Languages, to: Languages, completion: @escaping (Translation?) -> Void) {
        let request = TranslateRequest().getURLRequest(with: text, from: from, to: to)
        print(Thread.current)
        apiManager.sendRequest(request: request, with: text) { (result: Translation?) in
            guard let result = result else {
                completion(nil)
                return
            }
            completion(result)
        }
    }
}

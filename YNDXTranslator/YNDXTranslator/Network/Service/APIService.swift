//
//  APIService.swift
//  YNDXTranslator
//
//  Created by Egor on 25/01/2021.
//  Copyright © 2021 Egor. All rights reserved.
//

import Foundation
protocol IAPIService {
    func getTranslate(with text: String, from: Languages, to: Languages, completion: @escaping (String) -> Void) -> Void
}
class APIService: IAPIService {
    private let apiManager = APIManager()
    func getTranslate(with text: String, from: Languages, to: Languages, completion: @escaping (String) -> Void) {
        let request = TranslateRequest().getURLRequest(with: text, from: from, to: to)
        print(Thread.current)
        apiManager.sendRequest(request: request, with: text) { (result: Result<Translation, Error>) in
            switch result {
            case .success(let result):
                completion(result.translated_text["\(to)"]!)
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
}

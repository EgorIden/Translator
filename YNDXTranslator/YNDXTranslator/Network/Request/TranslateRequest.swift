//
//  TranslateRequest.swift
//  YNDXTranslator
//
//  Created by Egor on 24/01/2021.
//  Copyright © 2021 Egor. All rights reserved.
//

import Foundation
protocol IRequest {
    var headers: [String: String] {get set}
    var serviceUrl: String {get set}
    func getURLRequest(with text: String, from: Languages, to: Languages) -> URLRequest
}
struct TranslateRequest: IRequest {
    var headers = ["x-rapidapi-key": "46d93cb6fbmsh6972c75f41aa5d0p1c9d91jsn0d025c910a80",
                   "x-rapidapi-host": "nlp-translation.p.rapidapi.com"]
    var serviceUrl = "https://nlp-translation.p.rapidapi.com/v1/translate?"
    func getURLRequest(with text: String, from: Languages, to: Languages) -> URLRequest {
        let address = "\(serviceUrl)text=\(text)&to=\(to)&from=\(from)"
        let baseURL = URL(string: address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        var request = URLRequest(url: baseURL!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        return request
    }
}

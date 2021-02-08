//
//  MainModel.swift
//  YNDXTranslator
//
//  Created by Egor on 22/01/2021.
//  Copyright © 2021 Egor. All rights reserved.
//

import Foundation
protocol IMainModel {
    func translate(text: String, from: Languages, to: Languages, complition: @escaping (String?) -> Void)
}
class MainModel: IMainModel {
    private let apiService = APIService()
    func translate(text: String, from: Languages, to: Languages, complition: @escaping (String?) -> Void) {
        apiService.getTranslate(with: text, from: from, to: to) { result in
            guard let translanslation = result else {
                complition(nil)
                return
            }
            complition(translanslation.translated_text["\(to)"])
        }
    }
}

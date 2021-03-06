//
//  MainViewController.swift
//  YNDXTranslator
//
//  Created by Egor on 18/01/2021.
//  Copyright © 2021 Egor. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    //UI
    @IBOutlet weak var firstLang: UILabel!
    @IBOutlet weak var secondLang: UILabel!
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet weak var languagePicker: UIPickerView!
    private let darkBackgroundView = UIView()
    private let model = MainModel()
    private var currentLabel = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        textToTranslate.delegate = self
        textToTranslate.returnKeyType = .done
        translatedText.isUserInteractionEnabled = false
        languagePicker.isHidden = true
        languagePicker.delegate = self
        languagePicker.dataSource = self
        setupUI()
        setupGestures()
    }
    private func setupUI() {
        textToTranslate.textContainerInset.top = 12
        textToTranslate.textContainerInset.left = 10
        translatedText.textContainerInset.top = 12
        translatedText.textContainerInset.left = 10
        topBackgroundView.styling()
        textToTranslate.styling()
        translatedText.styling()
    }
    private func setupGestures() {
        let tapFirstLang = UITapGestureRecognizer(target: self, action: #selector(tapFirst(gestureRecongizer:)))
        firstLang.addGestureRecognizer(tapFirstLang)
        firstLang.isUserInteractionEnabled = true
        let tapSecondLang = UITapGestureRecognizer(target: self, action: #selector(tapSecond(gestureRecongizer:)))
        secondLang.addGestureRecognizer(tapSecondLang)
        secondLang.isUserInteractionEnabled = true
        let tapDarkView = UITapGestureRecognizer(target: self, action: #selector(tapDark(gestureRecongizer:)))
        darkBackgroundView.addGestureRecognizer(tapDarkView)
        darkBackgroundView.isUserInteractionEnabled = true
        darkBackgroundView.backgroundColor = UIColor(white: 0, alpha: 0.4)
    }
    private func showPicker() {
        languagePicker.isHidden = false
        darkBackgroundView.frame = self.view.frame
        self.view.addSubview(darkBackgroundView)
        self.view.bringSubviewToFront(languagePicker)
    }
    private func hidePicker() {
        languagePicker.isHidden = true
        self.darkBackgroundView.removeFromSuperview()
    }
    @objc func tapFirst(gestureRecongizer: UITapGestureRecognizer) {
        currentLabel = "first"
        showPicker()
    }
    @objc func tapSecond(gestureRecongizer: UITapGestureRecognizer) {
        currentLabel = "second"
        showPicker()
    }
    @objc func tapDark(gestureRecongizer: UITapGestureRecognizer) {
        hidePicker()
    }
}
extension MainViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch currentLabel {
        case "first":
            let lang = Languages.allCases[row].rawValue
            firstLang.text = lang
        case "second":
            let lang = Languages.allCases[row].rawValue
            secondLang.text = lang
        default:
            break
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Languages.allCases[row].rawValue
    }
}
extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Languages.allCases.count
    }
}
extension MainViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            let texts = textView.text!
            let from = Languages(rawValue: firstLang.text!)
            let to = Languages(rawValue: secondLang.text!)
            print(texts, from!, to!)
            model.translate(text: texts, from: from!, to: to!) { [weak self] result in
                self?.translatedText.text = result
            }
            view.endEditing(true)
            return false
        }else {
            return true
        }
    }
}

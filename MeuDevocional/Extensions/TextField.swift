//
//  MinhasDevocionais+UITextField.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 05/01/22.
//

import Foundation
import UIKit

///configurando a textField para receber apenas uma quantidade máxima de letras
private var kAssociationKeyMaxLength: Int = 0
extension UITextField {
        @IBInspectable var maxLength: Int {
            get {
                if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                    return length
                } else {
                    return Int.max
                }
            }
            set {
                objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
                addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
            }
        }

        @objc func checkMaxLength(textField: UITextField) {
            guard let prospectiveText = self.text,
                prospectiveText.count > maxLength
                else {
                    return
            }

            let selection = selectedTextRange
            let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
            let substring = prospectiveText[..<indexEndOfText]
            text = String(substring)
            selectedTextRange = selection
        }
}

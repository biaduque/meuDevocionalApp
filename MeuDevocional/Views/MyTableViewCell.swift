//
//  MyTableViewCell.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 20/07/21.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    //configurando o textField
    @IBOutlet weak var textFieldCell: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    //configurando a textfield para ficar no padrao apple de textField em table
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textFieldCell.translatesAutoresizingMaskIntoConstraints = false
        textFieldCell.frame = bounds
        textFieldCell.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension MyTableViewCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //essa funcao faz com que a tecla return do teclado faca o app aceitar a entrada e o teclado abaixe
    textFieldCell.resignFirstResponder()
    textFieldCell.returnKeyType = .done
    textFieldCell.autocapitalizationType = .words
    textFieldCell.frame = bounds
    return true
    }
    
    //funcao criada para printar o limite de caracteres da palavra chave
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        ///limitando o funcionamento da funcao apenas para as palavras chave
        if textFieldCell.placeholder == "Palavra chave 1" || textFieldCell.placeholder == "Palavra chave 2" || textFieldCell.placeholder == "Palavra chave 3"{
            guard let text = textField.text else { return true }
            let length = text.count + string.count - range.length
            let count = length
            label.text =  String(count) + "/15"
            return length < 15
        }
        return true
    }
}

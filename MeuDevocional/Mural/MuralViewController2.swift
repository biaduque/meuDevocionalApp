//
//  MuralViewController2.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 16/07/21.
//

import UIKit
import Foundation
import PhotosUI

protocol MuralViewController2Delegate: AnyObject {
    func didRegister()
}

class MuralViewController2: UIViewController {
    
    weak var delegate: MuralViewController2Delegate? //para atualizacao da collectionView

    public var dataPost: [Post] = []
    public var indice = 0
    private var minhaNota = ""
    private var selectedColor = "postit1"
    private var colorText = "Amarelo1"
    public var isEdit = false
    
    @IBOutlet weak var limitText: UILabel!
    @IBOutlet weak var minhaNotaInput: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var color1: UIButton?
    @IBOutlet weak var color2: UIButton?
    @IBOutlet weak var color3: UIButton?
    @IBOutlet weak var color4: UIButton?
    @IBOutlet weak var visualizacao: UIImageView!
    @IBOutlet weak var visualizacaoLabel: UILabel!
    
    private var imagePicker: ImagePicker!
    private var acesso = false
    private var isImage = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minhaNotaInput.delegate = self
        dataPost = try! CoreDataStackPost.getPost()
        okButton.layer.cornerRadius = 8
        
        ///photo picker
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.visualizacao.layer.cornerRadius = 10
        self.visualizacao.contentMode = .scaleAspectFill
        

    }
    
    // MARK: Buttons
    @IBAction func onTap(_ sender: Any) {
        if isEdit == true{
            indice = dataPost.count-1
        }
        dataPost.last?.nota = minhaNotaInput.text!
        
        if isImage != true {
            dataPost.last?.backgroundImage = selectedColor
        }
        dataPost.last?.color = colorText
        
        let date = Date()
        let formatter =  DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dataPost.last?.data =  formatter.string(from: date)
        
        //salvando
        try? CoreDataStackPost.saveContext()
        
        //atualiza a collectionView
        delegate?.didRegister()
        
        //salva no userDefault
        verifWidgets()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
       
            let ac = UIAlertController(title: "", message: "Tem certeza de que deseja descartar este novo motivo?", preferredStyle: .actionSheet)
                ac.addAction(UIAlertAction(title: "Ignorar alterações", style: .destructive, handler: {
                    [self] action in
                    ///opcoes de cancelamento
                    ///se for uma adicao, exclui o item que tinha adicionado anteriormente
                    try! CoreDataStackPost.deletePost(post: dataPost.last!)
                    delegate?.didRegister()
                    self.dismiss(animated: true, completion: nil)
                }))
                ac.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                present(ac, animated: true)
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        self.isImage = true
        let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization({status in
                    if status != .denied{
                        self.acesso = true

                    } else {
                        self.acesso = false
                    }
                })
            }
        else{
            let teste = PHPhotoLibrary.authorizationStatus()
            if teste != .denied{
                self.imagePicker.present(from: sender as! UIView)
            }
            else{
                print("Nao permitido")
            }
        }
    }
    
    // MARK: Funcao que verifica o userDefaults no mural para os widgets
    func verifWidgets(){
        let post = try! CoreDataStackPost.getPost()
        ///vai preencher o vetor de user Defaults com os postits de gratidao armazenados no coredata
        if post.count-1 != (UserDefaultsManager.shared.gratidao?.count){
            ///reseta o vetor do user defaults
            UserDefaultsManager.shared.background = [""]
            UserDefaultsManager.shared.gratidao = [""]
            var vetaux: [String] = [""]
            var vetaux2: [String] = [""]
            for i in 0..<post.count{
                vetaux.append(post[i].nota ?? "Pelo o que você é grato hoje?")
                vetaux2.append(post[i].backgroundImage ?? "postit1")
            }
            ///atualiza o vetor do user defaults
             UserDefaultsManager.shared.gratidao = vetaux
             UserDefaultsManager.shared.background = vetaux2
        }
        //print("gratidao",UserDefaultsManager.shared.gratidao)
    }
    
    // MARK: Colors Button
    
    //funcoes de selecao de cores
    @IBAction func clickColor1(_ sender: Any) {
        visualizacaoLabel.textColor = .white
        if isImage == false{
            visualizacao.image = UIImage(named: "postitView1")
            selectedColor = "postit1"
        }
        else{
            visualizacaoLabel.backgroundColor = UIColor(named: "Verde2")
        }
        //desativa as outras cores
        changeColor(button: color2!, cor: "color2")
        changeColor(button: color3!, cor: "color3")
        changeColor(button: color4!, cor: "color4")
        //ativa cor selecionada
        changeColor(button: color1!, cor: "color1s")
        colorText = "Verde2"
    }
    
    @IBAction func clickColor2(_ sender: Any) {
        visualizacaoLabel.textColor = .white
        if isImage == false{
            visualizacao.image = UIImage(named: "postitView2")
            selectedColor = "postit2"
        }
        else{
            visualizacaoLabel.backgroundColor = UIColor(named: "Amarelo1")
        }
        //desativa as outras cores
        changeColor(button: color1!, cor: "color1")
        changeColor(button: color3!, cor: "color3")
        changeColor(button: color4!, cor: "color4")
        //ativa cor atual
        changeColor(button: color2!, cor: "color2s")
        colorText = "Amarelo1"

    }
    @IBAction func clickColor3(_ sender: Any) {
        visualizacaoLabel.textColor = verde
        if isImage == false{
            visualizacao.image = UIImage(named: "postitView3")
            selectedColor = "postit3"
        }
        else{
            visualizacaoLabel.backgroundColor = UIColor(named: "Amarelo2")
        }
        //desativa as outras cores
        changeColor(button: color1!, cor: "color1")
        changeColor(button: color2!, cor: "color2")
        changeColor(button: color4!, cor: "color4")
        //ativa cor atual
        changeColor(button: color3!, cor: "color3s")
        colorText = "Amarelo2"

    }
    @IBAction func clickColor4(_ sender: Any) {
        visualizacaoLabel.textColor = amarelo
        if isImage == false {
            visualizacao.image = UIImage(named: "postitView4")
            selectedColor = "postit4"
        }
        else{
            visualizacaoLabel.backgroundColor = UIColor(named: "Amarelo3")
        }
        //desativa as outras cores
        changeColor(button: color1!, cor: "color1")
        changeColor(button: color2!, cor: "color2")
        changeColor(button: color3!, cor: "color3")
        //ativa cor atual
        changeColor(button: color4!, cor: "color4s")
        colorText = "Amarelo3"
    }
    
    //funcao para mudar a cor selecionada
    private func changeColor(button:UIButton, cor:String){
        button.setBackgroundImage(UIImage(named: cor), for: .normal)
    }
    
    //funcao para adicionar o texto
    @IBAction func atualizaTexto(_ sender: Any) {
        minhaNotaInput.returnKeyType = .done
        minhaNotaInput.autocapitalizationType = .words
        minhaNotaInput.delegate = self
        minhaNotaInput.resignFirstResponder()
        visualizacaoLabel.text = minhaNotaInput.text
    }
    
}

// MARK: Extension TextField
extension MuralViewController2: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //essa funcao faz com que a tecla return do teclado faca o app aceitar a entrada e o teclado abaixe
    visualizacaoLabel.text = minhaNotaInput.text
    textField.resignFirstResponder()
    return true
    }
    
    //funcao criada para printar o limite de caracteres da palavra chave
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

           guard let text = textField.text else { return true }
        let length = text.count + string.count - range.length
           // create an Integer of 15 - the length of your TextField.text to count down
           //let count = 15 - length
            let count = length
           // set the .text property of your UILabel to the live created String
           limitText.text =  String(count) + "/100"
           // if you want to limit to 15 charakters
           // you need to return true and <= 15

           return length < 100
       }
}

extension MuralViewController2: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.visualizacao.image = image
        self.visualizacao.alpha = 0.6
        dataPost.last?.backgroundImage = SalvarImagem.saveToFiles(image: self.visualizacao.image)
    }
}

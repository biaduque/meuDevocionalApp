//
//  DevocionalDiarioEstudoViewController.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 15/07/21.
//

import UIKit

class DevocionalDiarioEstudoViewController: UIViewController {
    //carrega o banco de dados dessas devocionais
    
    //estudo biblico selecionado
    public var estudo = 0
    public var cell = 0
    
    //vetor que armazenara a base de devocionais de acordo com o que for selecionado
    private var base: [CollectionItem] = []
    
    public var aplicacao1: [String] = []
    public var aplicacao2: [String] = []
    public var aplicacao3: [String] = []
    public var anotacao: [String] = []
    public var keySelected1 = ""
    public var keySelected2 = ""
    public var keySelected3 = ""
    public var keySelected4 = ""
        
    
    //variaveis mutaveis de acordo com o array
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var baseBiblica: UILabel!
    @IBOutlet weak var imagemTema: UIImageView!
    @IBOutlet weak var contextualizacao: UILabel!
    @IBOutlet weak var contextualizacaoConteudo: UITextView!
    @IBOutlet weak var reflexaoConteudo: UITextView!
    @IBOutlet weak var conclusaoConteudo: UITextView!
    
    //inputs do usuario
    @IBOutlet weak var fieldAplicacao1: UITextField!
    @IBOutlet weak var fieldAplicacao2: UITextField!
    @IBOutlet weak var fieldAplicacao3: UITextField!
    @IBOutlet weak var anotacoesPessoais: UITextView!
    
    //botoes de checklist
    @IBOutlet weak var check1: UIButton!
    @IBOutlet weak var check2: UIButton!
    @IBOutlet weak var check3: UIButton!
    
    @IBOutlet weak var play: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        
        editButton(button: play)
        // MARK: Carregar conteúdo
        ///carregar dados das devocionais
        #warning("Precisa ficar na viewDidLoad caso contrario da erro")
        
        if cell == 1{
            //cria a devocional que foi clicada
            criaCotidiano(indice: estudo)
            //atualiza o vetor que é atualizado e alimentado
            base = cotidianoBase
        }
        else if cell == 2{
            criaVida(indice: estudo)
            base = vidaBase
        }
        else{
            criaEstudos(indice: estudo)
            base = estudosBase
        }
        
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        ///carrega devocionais default
        titulo.text = base[estudo].titulo
        baseBiblica.text = base[estudo].baseBiblica
        imagemTema.image = base[estudo].backgroundImage
        contextualizacaoConteudo.text = base[estudo].contextualizacao
        reflexaoConteudo.text = base[estudo].reflexao
        conclusaoConteudo.text = base[estudo].conclusao
        
        ///carrega dados armazenados dos usuarios
        self.selecionaBaseDados()
    
        aplicacao1 = defaults.object(forKey: keySelected1) as? [String] ?? [String]()
        aplicacao2 = defaults.object(forKey: keySelected2) as? [String] ?? [String]()
        aplicacao3 = defaults.object(forKey: keySelected3) as? [String] ?? [String]()
        anotacao = defaults.object(forKey: keySelected4) as? [String] ?? [String]()
        
        self.selecionaVetores()
        
        // MARK: Conteúdo editável
        
        ///verificacao dos inputs na textField
        fieldAplicacao1.text = aplicacao1[estudo]
        fieldAplicacao2.text = aplicacao2[estudo]
        fieldAplicacao3.text = aplicacao3[estudo]
        
        ///verificando o check de cada field
        self.confereMark(textField: fieldAplicacao1, button: check1)
        self.confereMark(textField: fieldAplicacao2, button: check2)
        self.confereMark(textField: fieldAplicacao3, button: check3)
        
        ///verificacao da anotacao pessoal
        ///define o tipo de texto que sera mostrado ao usuário na reflexao (se é o armazenado ou o default)
        
        if anotacao[estudo] != ""{
            anotacoesPessoais.text = anotacao[estudo]
        }
        else{
            anotacoesPessoais.text = "Comece a escrever..."
            anotacoesPessoais.textColor = UIColor.lightGray
        }
        
        // MARK: Delegates
        fieldAplicacao1.delegate = self
        fieldAplicacao2.delegate = self
        fieldAplicacao3.delegate = self
        anotacoesPessoais.delegate = self
    }
    
    // MARK: Buttons
    @IBAction func saveButton(_ sender: Any) {
        aplicacao1[estudo] = fieldAplicacao1.text!
        aplicacao2[estudo] = fieldAplicacao2.text!
        aplicacao3[estudo] = fieldAplicacao3.text!
        
        if anotacoesPessoais.textColor == UIColor.lightGray {
            anotacao[estudo] = ""

        }
        else{
            anotacao[estudo] = anotacoesPessoais.text!

        }        
        defaults.set(aplicacao1,forKey: keySelected1)
        defaults.set(aplicacao2,forKey: keySelected2)
        defaults.set(aplicacao3,forKey: keySelected3)
        defaults.set(anotacao,forKey: keySelected4)
        
        let ac = UIAlertController(title: "Você salvou as alterações", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in}))
        present(ac, animated: true)
        
        hideKeyboard()
    }
    
    @IBAction func playMusicButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "music") as?
                    DevocionalMusicViewController {
            vc.recebe  = base[estudo].link
            navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    // MARK: Selecao de conteudos do user default de acordo com a celula
    private func selecionaBaseDados(){
        if cell == 1{
            keySelected1 = "baseAplicacaoCotidiano1"
            keySelected2 = "baseAplicacaoCotidiano2"
            keySelected3 = "baseAplicacaoCotidiano3"
            keySelected4 = "baseAnotacaoCotidiano"
        }
        else if cell == 2{
            keySelected1 = "baseAplicacaoVida1"
            keySelected2 = "baseAplicacaoVida2"
            keySelected3 = "baseAplicacaoVida3"
            keySelected4 = "baseAnotacaoVida"
        }
        else if cell == 3{
            keySelected1 = "baseAplicacaoEstudos1"
            keySelected2 = "baseAplicacaoEstudos2"
            keySelected3 = "baseAplicacaoEstudos3"
            keySelected4 = "estudosAnotacao"
        }
    }
    
    // MARK: User defaults inicialização
    private func selecionaVetores(){
        if cell == 1{
            if aplicacao1.count == 0{
                aplicacao1 = ["","","","",""]
                aplicacao2 = ["","","","",""]
                aplicacao3 = ["","","","",""]
                anotacao = ["","","","",""]
                defaults.set(aplicacao1,forKey: keySelected1)
                defaults.set(aplicacao2,forKey: keySelected2)
                defaults.set(aplicacao3,forKey: keySelected3)
                defaults.set(anotacao,forKey: keySelected4)
            }
        }
        else if cell == 2{
            if aplicacao1.count == 0{
                aplicacao1 = ["","","","","",""]
                aplicacao2 = ["","","","","",""]
                aplicacao3 = ["","","","","",""]
                anotacao = ["","","","","",""]
                defaults.set(aplicacao1,forKey: keySelected1)
                defaults.set(aplicacao2,forKey: keySelected2)
                defaults.set(aplicacao3,forKey: keySelected3)
                defaults.set(anotacao,forKey: keySelected4)
            }
        }
        else {
            if aplicacao1.count == 0{
                aplicacao1 = ["","","","",""]
                aplicacao2 = ["","","","",""]
                aplicacao3 = ["","","","",""]
                anotacao = ["","","","",""]
                defaults.set(aplicacao1,forKey: keySelected1)
                defaults.set(aplicacao2,forKey: keySelected2)
                defaults.set(aplicacao3,forKey: keySelected3)
                defaults.set(anotacao,forKey: keySelected4)

            }
        }
        
        
    }
    
    // MARK: Edicao e conferencia
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        //anotacoesPessoais.resignFirstResponder()
        hideKeyboard()
        self.view.endEditing(true)
    }
    
    ///funcao que adiciona sombra no botao de play
    private func editButton(button:UIButton){
        button.layer.backgroundColor = nil
        button.layer.cornerRadius = 1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOpacity = 1.5
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
    }
  
    private func confereMark(textField: UITextField, button: UIButton){
        if textField.text != ""{
            button.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
        else{
            button.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
    }
}

// MARK: Extension Text Field
extension DevocionalDiarioEstudoViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ///essa funcao faz com que a tecla return do teclado faca o app aceitar a entrada e o teclado abaixe
        textField.resignFirstResponder()
        return true
    }
}

extension DevocionalDiarioEstudoViewController: UITextViewDelegate{
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
       textField.resignFirstResponder()
       return true;
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if anotacoesPessoais.textColor == UIColor.lightGray {
            anotacoesPessoais.text = ""
            anotacoesPessoais.textColor = .label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if anotacoesPessoais.text == "" {
            anotacoesPessoais.text = "Comece a escrever ..."
            anotacoesPessoais.textColor = UIColor.lightGray
        }
    }
}





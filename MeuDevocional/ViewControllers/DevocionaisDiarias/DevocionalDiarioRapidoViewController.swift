//
//  DevocionalDiarioRapidoViewController.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 14/01/22.
//

import UIKit

class DevocionalDiarioRapidoViewController: UIViewController {
    public var devocional: Devocional?
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var refBiblicaLabel: UILabel?
    @IBOutlet weak var contextualizacaoLabel: UILabel?
    @IBOutlet weak var reflexaoLabel: UILabel?
    
    @IBOutlet weak var musicButton: UIButton!
    
    public var versiculo = ""
    public var musica = ""
    public var introducao = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contextualizacaoLabel?.textColor = .label
        self.reflexaoLabel?.textColor = .label
        editButton(button: musicButton)
        content()
    }
    
    
    @IBAction func newDevocionalButton(_ sender: Any) {
        ///alerta de cancelar
        let ac = UIAlertController(title: "Criar nova devovional", message: "Deseja criar uma nova devocional através dessa devocional rápida?", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Criar devocional", style: .cancel, handler: {
                ///abre a view controller de nova devocional
                [self] action in
                if let vc = self.createDevocional(){
                    present(vc, animated: true, completion: nil)
                }
            }))
            ac.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: {
                [self] action in
                    self.dismiss(animated: true, completion: nil)
            }))
            present(ac, animated: true)
    }
    
    private func checkDevocional(titulo: String) -> Int {
        let dataDevocional = try! CoreDataStack.getDevocional()
        for i in 0..<dataDevocional.count{
            ///se a devocional existir, ela sera editada
            if dataDevocional[i].titulo == titulo{
                return i
            }
        }
        ///se a devocional nao existir, ela sera criada e colocada por ultimo
        let _ = try? CoreDataStack.createDevocional(titulo: self.titleLabel?.text ?? "",
                                                    baseBiblica: self.versiculo,
                                                    contextualizacao: "",
                                                    reflexao: self.introducao,
                                                    conclusao: "",
                                                    aplicacao1: "",
                                                    aplicacao2: "",
                                                    aplicacao3: "",
                                                    backgroundColor: "1",
                                                    backgroundImage: "crie2",
                                                    link: self.musica,
                                                    livro: self.versiculo,
                                                    capitulo: "",
                                                    versiculo: "",
                                                    data: "")
        return dataDevocional.count
    }
    
    private func createDevocional() -> UIViewController? {
        if let vc = storyboard?.instantiateViewController(identifier: "minhadevocionalForms") as? MinhaDevocional3ViewController {
            let index = checkDevocional(titulo: self.titleLabel?.text ?? "Nova devocional")
            vc.edit = true
            vc.rapida = true
            vc.indice = index
            return vc
        }
        return nil
    }
    
    @IBAction func openMusic(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "music") as?
                    DevocionalMusicViewController {
            vc.recebe  = devocional!.musica
            navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    
    private func content(){
        self.titleLabel?.text = devocional?.titulo
        let parte1 =  devocional!.introducao
        let parte2 = devocional!.refBiblica
        self.refBiblicaLabel?.text =  "\(parte1) - \(parte2)"
        self.contextualizacaoLabel?.text = devocional?.desenvolvimento
        self.reflexaoLabel?.text = devocional?.conclusao
        
        self.versiculo = devocional!.refBiblica
        self.introducao = devocional!.desenvolvimento
        self.musica = devocional!.musica
        
    }
    
    /// altera o visual do botao de play
    private func editButton(button:UIButton){
        button.layer.backgroundColor = nil
        button.layer.cornerRadius = 1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOpacity = 2
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
    }
    
}

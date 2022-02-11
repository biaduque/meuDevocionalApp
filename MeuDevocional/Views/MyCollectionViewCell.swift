//
//  MyCollectionViewCell.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 15/07/21.
//

import UIKit

//classe das celulas das devocionais
class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleCard: UILabel!
    @IBOutlet weak var textCard: UILabel!
    
    
    //celulas personalizadas
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myReference: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    
    //palavras-chave
    @IBOutlet weak var pc1: UILabel!
    @IBOutlet weak var pc2: UILabel!
    @IBOutlet weak var pc3: UILabel!
    
    //data
    @IBOutlet weak var data: UILabel!
    
    
    //empty-view para conexoes
    @IBOutlet weak var buttonEmpty: UIButton!
    @IBOutlet weak var textEmpty: UILabel!
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var versicleLabel: UILabel!
    @IBOutlet weak var waitView: UIActivityIndicatorView!
    
    // MARK: Devocionais rápidas
    public func editaRapidas(devocional: Devocional,status: Bool){
            ///quando consegue carregar o conteúdo, esconte as empty states
            self.waitView.isHidden = true
            self.buttonEmpty.isHidden = true
            self.textEmpty.isHidden = true
            self.emptyImage.isHidden = true
            
            self.titleCard.isHidden = false
            self.textCard.isHidden = false
            self.versicleLabel.isHidden = false
            
            ///editando a celula
            titleCard.text = devocional.titulo
            textCard.text = devocional.refBiblica
            versicleLabel.text = devocional.introducao

    }
    public func editaEmpty(status: Bool){
        if status == false{
            self.buttonEmpty.layer.cornerRadius = 3
            self.buttonEmpty.isHidden = false
            self.textEmpty.isHidden = false
            self.emptyImage.isHidden = false
            self.waitView.isHidden = false
            
            self.waitView.startAnimating()

            
            self.titleCard.isHidden = true
            self.textCard.isHidden = true
            self.versicleLabel.isHidden = true
        }
    }
    
    public func stylize(){
        let newColor = UIColor(named: colors[Int.random(in: 0..<colors.count)])
        self.backgroundColor = newColor?.withAlphaComponent(0.3)
        self.layer.cornerRadius = 10
        self.titleCard.textColor = UIColor(named: "Accent")
        self.textCard.textColor = UIColor(named: "Accent")?.withAlphaComponent(0.7)
        self.versicleLabel.textColor = UIColor(named: "Accent")?.withAlphaComponent(0.7)
    }
    
    
    
    // MARK: Minhas devocionais
    /// --------- Funcoes auxiliares -----------
    func editaCelula(index: Int, dataDevocional: [Devocionais]){
        ///seleciona o que tem no banco de dados para exibir
        
        self.data.text = dataDevocional[index].data
        self.myTitle.text = dataDevocional[index].titulo
        self.myReference.text = dataDevocional[index].baseBiblica
        self.myImage.image = UIImage(named: dataDevocional[index].backgroundImage!)
        
    
        self.pc1.text = dataDevocional[index].aplicacao1
        self.pc2.text = dataDevocional[index].aplicacao2
        self.pc3.text = dataDevocional[index].aplicacao3
                
        self.pc1.clipsToBounds = true
        self.pc2.clipsToBounds = true
        self.pc3.clipsToBounds = true

        self.pc1.layer.cornerRadius = 3
        self.pc2.layer.cornerRadius = 3
        self.pc3.layer.cornerRadius = 3
                
        ///define o background de acordo com o codigo armazenado
        if dataDevocional[index].backgroundColor == "1"{
            self.backgroundColor = verde
            self.myImage.image = UIImage(named: "criev1")
            self.editPC(aplicacao: dataDevocional[index], color: UIColor(named: "Amarelo1") ?? verde3)
        }
        else if dataDevocional[index].backgroundColor == "2" {
            self.backgroundColor = amarelo
            self.myImage.image = UIImage(named: "criev2")
            self.editPC(aplicacao: dataDevocional[index], color: UIColor(named: "Amarelo3") ?? verde3)
        }
        else if dataDevocional[index].backgroundColor == "3"{
            self.backgroundColor = amarelo2
            self.myImage.image = UIImage(named: "criev3")
            self.editPC(aplicacao: dataDevocional[index], color: UIColor(named: "Verde1") ?? verde3)
        }
        else{
            self.backgroundColor = amarelo3
            self.myImage.image = UIImage(named: "criev4")
            self.editPC(aplicacao: dataDevocional[index], color: UIColor(named: "Verde2") ?? verde3)
        }
        
    }
    
    func editPC(aplicacao: Devocionais, color: UIColor){
        ///adiciona background nas palavras - chave apenas se houver algo adicionado
        if aplicacao.aplicacao1 != "" {self.pc1.backgroundColor = color.withAlphaComponent(0.4)}
        if aplicacao.aplicacao2 != "" {self.pc2.backgroundColor = color.withAlphaComponent(0.4)}
        if aplicacao.aplicacao3 != "" {self.pc3.backgroundColor = color.withAlphaComponent(0.4)}
    }
    
    ///define a cor do texto de acordo com o backgrund
    func defineTextColor(){
        if self.backgroundColor == verde {
            self.data.textColor = .white
            self.myTitle.textColor = .white
            self.myReference.textColor = .white
        }
        else if self.backgroundColor == amarelo{
            self.data.textColor = .white
            self.myTitle.textColor = .white
            self.myReference.textColor = .white
        }
        else if self.backgroundColor == amarelo2{
            self.data.textColor = verde
            self.myTitle.textColor = verde
            self.myReference.textColor = verde
        }
        else {
            self.data.textColor = amarelo
            self.myTitle.textColor = amarelo
            self.myReference.textColor = amarelo
        }
    }
    
}

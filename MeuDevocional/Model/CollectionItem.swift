///Esse arquivo é a classe de cada item da devocional

import UIKit

open class CollectionItem{
    
    open var titulo: String
    open var baseBiblica: String
    open var contextualizacao: String
    open var reflexao: String
    open var conclusao: String
    open var aplicacao1: String
    open var aplicacao2: String
    open var aplicacao3: String
    open var backgroundColor: UIColor
    open var backgroundImage: UIImage
    open var link: String
    
    public init(){
        titulo = " "
        baseBiblica = " "
        contextualizacao = ""
        reflexao = ""
        conclusao = ""
        aplicacao1 = " "
        aplicacao2 = " "
        aplicacao3 = " "
        backgroundColor = verde
        backgroundImage = UIImage(named: "crie2")!
        link = "https://www.youtube.com/watch?v=7SO3ObU99e4&list=RD7SO3ObU99e4&start_radio=1"
    }
    public init(titulo: String, baseBiblica: String, contextualizacao: String, reflexao: String, conclusao: String, aplicacao1: String, aplicacao2: String, aplicacao3: String, backgroundColor: UIColor, backgroundImage: UIImage, link: String) {
        self.titulo = titulo
        self.baseBiblica = baseBiblica
        self.contextualizacao = contextualizacao
        self.reflexao = reflexao
        self.conclusao = conclusao
        self.aplicacao1 = aplicacao1
        self.aplicacao2 = aplicacao2
        self.aplicacao3 = aplicacao3
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.link = link
    }
}

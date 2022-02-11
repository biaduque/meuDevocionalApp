//
//  CollectionItemMural.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 11/02/22.
//

/// Classe dos itens do mural

import UIKit

open class CollectionItemMural{
    
    open var nota: String
    open var backgroundImage: UIImage
    
    public init(){
        nota = " "
        backgroundImage = UIImage(named: "novopost")!
    }
    public init(nota: String, backgroundImage: UIImage) {
        self.nota = nota
        self.backgroundImage = backgroundImage
    }
}

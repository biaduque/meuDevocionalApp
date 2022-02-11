//
//  EmptyView.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 05/01/22.
//

import Foundation
import UIKit

// MARK: MURAL -> Empty View
///base de dados mostrado ao usuário na aba mural
var item0 = CollectionItemMural(nota: "", backgroundImage: UIImage(named:"base1")!)
var item1 = CollectionItemMural(nota: "", backgroundImage: UIImage(named:"base2")!)
var meuMural: [CollectionItemMural] = [item0,item1]

// MARK: Devocionais diárias -> Empty View
///base de dados mostrado ao usuário na aba Meu Devocional
var devocional0 = CollectionItem(titulo: "", baseBiblica: "", contextualizacao: "", reflexao: "", conclusao: "", aplicacao1: " ", aplicacao2: " ", aplicacao3: " ", backgroundColor: .clear, backgroundImage: UIImage(named: "crieBase2")!,link:"https://www.youtube.com/watch?v=7SO3ObU99e4&list=RD7SO3ObU99e4&start_radio=1")
var devocional1 = CollectionItem(titulo: "", baseBiblica: "", contextualizacao: "", reflexao: "", conclusao: "", aplicacao1: " ", aplicacao2: " ", aplicacao3: " ", backgroundColor: .clear, backgroundImage: UIImage(named: "crieBase")!,link:"https://www.youtube.com/watch?v=7SO3ObU99e4&list=RD7SO3ObU99e4&start_radio=1")
var devocional2 = CollectionItem(titulo: "", baseBiblica: "", contextualizacao: "", reflexao: "", conclusao: "", aplicacao1: " ", aplicacao2: " ", aplicacao3: " ", backgroundColor: .clear, backgroundImage: UIImage(named: "crieBase3")!,link:"https://www.youtube.com/watch?v=7SO3ObU99e4&list=RD7SO3ObU99e4&start_radio=1")
var meuDevocional: [CollectionItem] = [devocional0,devocional1,devocional2]

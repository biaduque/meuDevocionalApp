//
//  DevocionaisRapidas.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 14/01/22.
//

import Foundation


struct Devocional: Codable{
    var id: Int
    var titulo: String
    var refBiblica: String //livro: capitulo-versiculo
    var introducao: String //trecho da biblia
    var desenvolvimento: String //contextualizacao
    var conclusao: String //reflexao
    var musica: String //link da musica
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case titulo = "titulo"
        case refBiblica = "refBiblica"
        case introducao =  "introducao"
        case desenvolvimento = "desenvolvimento"
        case conclusao = "conclusao"
        case musica = "musica"
    }
}

extension Devocional: CustomStringConvertible {
    var description: String {
        return "{id: \(id),refBiblica:\(refBiblica), introducao: \(introducao), titulo: \(titulo), desenvolvimento: \(desenvolvimento), conclusao: \(conclusao)}"
    }
}


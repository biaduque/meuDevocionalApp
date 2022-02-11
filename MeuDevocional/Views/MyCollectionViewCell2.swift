//
//  MyCollectionViewCell2.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 24/01/22.
//

import UIKit


//classe das celulas dos post its (em Mural)
class MyCollectionViewCell2: UICollectionViewCell{
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var nota: UILabel!
    @IBOutlet weak var data: UILabel!
    
    func setImage(image: String,color: String){
           if image != "postit1" &&
               image != "postit2" &&
               image != "postit3" &&
               image != "postit4" &&
               image != "novopost" {
               
               let path = image
               let imageNew = UIImage(contentsOfFile: SalvarImagem.getFilePath(fileName: path))
               self.background.image = imageNew
               self.background.alpha = 0.6
               self.background.layer.cornerRadius = 10
               self.background.contentMode = .scaleAspectFill
               self.nota.backgroundColor = UIColor(named: color)
               self.data.backgroundColor = UIColor(named: color)
           }
           else{
               self.background.image = UIImage(named: image)
               self.background.alpha = 1
               self.nota.backgroundColor = .clear
               self.data.backgroundColor = .clear
           }
    }
}

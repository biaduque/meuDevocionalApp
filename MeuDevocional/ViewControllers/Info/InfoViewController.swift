//
//  InfoViewController.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 27/07/21.
//

import UIKit

class InfoViewController: UIViewController {
    var imagem: String = ""
    
    @IBOutlet weak var imagemBase: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imagem muda de acordo com a tela
        imagemBase.image = UIImage(named: imagem)
    }

    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

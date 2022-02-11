//
//  MuralViewController.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 16/07/21.
//

import UIKit

class MuralViewController: UIViewController {
    public var minhaNota = ""
    public var selectedIndex: Int = 0
    private var isFirstRun = true
    public var dataPost1: [Post] = []
    
    @IBOutlet weak var muralCollection: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("gratidao",UserDefaultsManager.shared.gratidao)

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "Accent")]
        
        muralCollection.dataSource = self
        muralCollection.delegate = self
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
                muralCollection.addGestureRecognizer(longPress)
    }
    
    
    // MARK: Buttons
    
    @IBAction func addButton(_ sender: Any) {
    }
    
    @IBAction func infoView(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "info") as?
                    InfoViewController {
            vc.imagem = "mural"
            navigationController?.present(vc, animated: true, completion: nil)
            }
    }
    
    // MARK: Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //adiciona o card que sera apenas editado na proxima view...
        let _ = try? CoreDataStackPost.createPost(nota: " ", backgroundImage: "novopost", data: "",color: "Amarelo1")
        muralCollection.reloadData()
        let vc = segue.destination as! MuralViewController2
        vc.delegate = self
   }
    
    // MARK: Long press
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        let dataMural = try! CoreDataStackPost.getPost()
        if sender.state == .began {
            let touchPoint = sender.location(in: muralCollection)
            if let indexPath = muralCollection.indexPathForItem(at: touchPoint) {
                if dataMural.count == 0{
                    let ac = UIAlertController(title: "Não é possível deletar", message: nil, preferredStyle: .actionSheet)
                        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                            [weak self] action in
                            self?.muralCollection.reloadData()
                            
                    }))
                    present(ac, animated: true)
                }
                else{
                let ac = UIAlertController(title: "Deletar '\(dataMural[indexPath.item].nota ?? "NONE")'", message: "O conteúdo não poderá ser recuperado.", preferredStyle: .actionSheet)
                    ac.addAction(UIAlertAction(title: "Deletar", style: .destructive, handler: {
                        [weak self] action in
                        try! CoreDataStackPost.deletePost(post: dataMural[indexPath.row])
                    self?.muralCollection.reloadData()
                    }))
                    ac.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                    present(ac, animated: true)}
            }
        }
    }
    
}



// MARK: Collection View
extension MuralViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //retorna a quantidade de PostIts presentes no meu CoreData
        let post = try! CoreDataStackPost.getPost()
        if post.count == 0{
            //se nada foi adicionado no banco de dados, vai mostrar a dataBase disponibilizada no app
            return meuMural.count
        }
        return post.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MyCollectionViewCell2 = muralCollection.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as! MyCollectionViewCell2
        let post = try! CoreDataStackPost.getPost()
        //se nao houver nenhuma adicao no banco de dados, mostra os dados base do App
        if post.count == 0{
            cell.nota.text = meuMural[indexPath.row].nota
            cell.background.image = meuMural[indexPath.row].backgroundImage
            cell.data.text = ""
            return cell
        }
        //caso haja valores no banco de dados, mostra os dados do Banco de dados
        cell.nota.text = post[indexPath.row].nota
        cell.data.text = post[indexPath.row].data
        cell.setImage(image: post[indexPath.row].backgroundImage ?? "postit1",color:  post[indexPath.row].color ?? "Verde2")
        changeTextColor(cell: cell, color:  post[indexPath.row].color ?? "semCor")
        cell.layer.cornerRadius = 15
        
        return cell
    }
    func changeTextColor(cell: MyCollectionViewCell2, color: String){
        cell.nota.font = UIFont(name:"Helvetica-Bold",size:17)
        
        if cell.background.image == UIImage(named: "postit1") || color == "Verde2"{
            cell.nota.textColor = .white
            cell.data.textColor = .white
        }
        else if cell.background.image == UIImage(named: "postit2") || color == "Amarelo1"{
            cell.nota.textColor = .white
            cell.data.textColor = .white
        }
        else if cell.background.image == UIImage(named: "postit3") || color == "Amarelo2"{
            cell.nota.textColor = verde
            cell.data.textColor = verde
        }
        else if cell.background.image == UIImage(named: "postit4") || color == "Amarelo3"{
            cell.nota.textColor = amarelo
            cell.data.textColor = amarelo
        }
    }
    
}



extension MuralViewController: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataPost1 = try! CoreDataStackPost.getPost()
        if dataPost1.count != 0{
            let ac = UIAlertController(title:"Meu motivo", message: dataPost1[indexPath.row].nota, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    [weak self] action in
                    self?.muralCollection.reloadData()
            }))
            present(ac, animated: true)
        }
        
        muralCollection.reloadData()
    }
}

// MARK: Delegate
extension MuralViewController: MuralViewController2Delegate{
    func didRegister(){
        muralCollection.reloadData()
    }
}

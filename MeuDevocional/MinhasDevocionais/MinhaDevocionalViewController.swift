//
//  CollectionViewController.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 28/07/21.
//

import UIKit
import CoreData


class MinhaDevocionalViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,NSFetchedResultsControllerDelegate {

    @IBOutlet var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var notFound: UIImageView!
    
    public var minhasDevocionais: [CollectionItem] = []
    private let reuseIdentifier4 = "cell4"
    var searching = false
    var dataDevocional: [Devocionais] = []
    var dataFiltred: [Devocionais] = []
    
    // MARK: Fetch Data
    private lazy var fetchResultController: NSFetchedResultsController<Devocionais> = {
        let request: NSFetchRequest<Devocionais> = Devocionais.fetchRequest() 
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Devocionais.data, ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: CoreDataStack.context,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "Accent")]
        //navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Accent")]
        
        super.viewDidLoad()
        self.dataDevocional = try! CoreDataStack.getDevocional()
        self.notFound.isHidden = false
        collectionView.delegate = self
        collectionView.dataSource = self
        self.configureSearchController()
        
        ///gesto para excluir a celula se for pressionada
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
                collectionView.addGestureRecognizer(longPress)
        
        ///fetch results
        do {
            try fetchResultController.performFetch()
            self.dataDevocional = fetchResultController.fetchedObjects ?? []
        } catch {
            fatalError("Nao foi possivel atualizar conteudo")
        }
    }
    
    // MARK: Info view
    ///tela de informacao
    @IBAction func infoView(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "info") as?
                    InfoViewController {
            vc.imagem = "devos"
            navigationController?.present(vc, animated: true, completion: nil)
            }
    }
    
    // MARK: Prepare (edicao e devocional)
    ///funcao que ira gerar o modal para a criacao da nova colecction
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ///adiciona o card que sera apenas editado na proxima view...
        let _ = try? CoreDataStack.createDevocional(titulo: "", baseBiblica: "", contextualizacao: "", reflexao: "", conclusao: "", aplicacao1: "", aplicacao2: "", aplicacao3: "", backgroundColor: "1", backgroundImage: "crie2", link: "",livro: "",capitulo: "",versiculo: "",data: "")
        self.collectionView?.reloadData()
        let vc = segue.destination as! MinhaDevocional3ViewController
        vc.edit = false
        vc.delegate = self
   }
    

    
    ///Funcoes da collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    ///Retorna a quantidade de itens da collection. Se nao forem os dados do usuario, retorna um item default
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ///nao encontrou nenhum resultado e habilita a empty view
        if dataFiltred.count == 0 && searching == true {
            self.notFound.isHidden = false
            return 0
        }
        self.notFound.isHidden = true
        
        self.dataDevocional = try! CoreDataStack.getDevocional() //get para corrigir problema de sincronismo
        ///empty view
        if dataDevocional.count == 0 && searching == false {
            searchController.searchBar.isHidden = true
            return meuDevocional.count
        }
        ///caso de mostrar a colection filtrada
        searchController.searchBar.isHidden = false
        if searching{
            //self.dataDevocional = dataFiltred
            return dataFiltred.count
        }
        else{
            return dataDevocional.count
        }
    }
    
    // MARK: Coleta de dados
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //guard let devocionais = controller.fetchedObjects as? [Devocionais] else { return }
        let devocionais = try! CoreDataStack.getDevocional()
        self.dataDevocional = devocionais
        self.collectionView.reloadData()
    }
    
    
    // MARK: Edicao da celula
    ///Funcao que retorna a celula editada
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellBase = UICollectionViewCell()
    
        if let cell: MyCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier4, for: indexPath as IndexPath) as? MyCollectionViewCell {
        
        cell.layer.cornerRadius = 15
        
        ///editando o visual dos elementos da celula
        ///se nao houver adicoes no banco de dados, pega a devocional disponibilizada como base
        if dataDevocional.count == 0 && searching == false{
            cell.data.text = ""
            cell.myTitle.text = meuDevocional[indexPath.row].titulo
            cell.myImage.image = meuDevocional[indexPath.row].backgroundImage
            cell.myReference.text = meuDevocional[indexPath.row].baseBiblica
            cell.backgroundColor = .clear
            cell.pc1.text = ""
            cell.pc2.text = ""
            cell.pc3.text = ""
        }
        else{
            ///caso ja houverem dados no Banco de dados, mostra eles aos usuarios
            if searching{
                cell.editaCelula(index: indexPath.row, dataDevocional: dataFiltred)
                cell.defineTextColor()
            }
            else{
                cell.editaCelula(index: indexPath.row, dataDevocional: dataDevocional)
                cell.defineTextColor()
            }
        }
        
        ///deixa o background da palavra chave vazio caso nao exista nada adicionado
        if cell.pc1.text == "" {cell.pc1.backgroundColor = nil}
        if cell.pc2.text == "" {cell.pc2.backgroundColor = nil}
        if cell.pc3.text == "" {cell.pc3.backgroundColor = nil}
        
        cellBase = cell
        }
        
        return cellBase
    
    }
    
    // MARK: Clique na celula
    ///clique na celula leva para a visualizacao do conteudo
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// se nao houver nenhuma criada, começa a criar uma
        if dataDevocional.count == 0 {
            if let vc = storyboard?.instantiateViewController(identifier: "minhadevocionalForms") as?
                        MinhaDevocional3ViewController {
                ///adiciona o card que sera apenas editado na proxima view...
                let _ = try? CoreDataStack.createDevocional(titulo: "", baseBiblica: "", contextualizacao: "", reflexao: "", conclusao: "", aplicacao1: "", aplicacao2: "", aplicacao3: "", backgroundColor: "1", backgroundImage: "crie2", link: "",livro: "",capitulo: "",versiculo: "",data: "")
                self.collectionView?.reloadData()
                vc.edit = false
                vc.delegate = self
                navigationController?.present(vc, animated: true)
                }
        }
        else{
            if let vc = storyboard?.instantiateViewController(identifier: "minhadevocional") as?
                        MinhaDevocional2ViewController {
                var index = 0
                if searching{
                    index = self.searchDevocional(Titulo: dataFiltred[indexPath.row].titulo!,isSearching: true)
                }
                else{
                    index = self.searchDevocional(Titulo: dataDevocional[indexPath.row].titulo!,isSearching: true)
                }
                vc.devocional = index
                vc.delegate2 = self
                //self.collectionView?.reloadData()
                navigationController?.pushViewController(vc, animated: true)
                }
        }
    
    }
    
    ///funcao auxiliar que busca a devocional atraves do titulo
    func searchDevocional(Titulo: String, isSearching: Bool) -> Int{
        let devocionaisAtuais = self.dataDevocional
        var index = 0
        for i in 0..<devocionaisAtuais.count{
            if (devocionaisAtuais[i].titulo!.lowercased()) == (Titulo.lowercased()){
                index = i
            }
        }
        return index
    }
    

    
    // MARK: Long Press function
    ///funcao que gera a exclusao do item se for pressionado
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if searching == false{
        //let dataDevocional = try! CoreDataStack.getDevocional()
            if sender.state == .began {
                let touchPoint = sender.location(in: collectionView)
                if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
                    if dataDevocional.count == 0{
                        let ac = UIAlertController(title: "Não é possível deletar", message: nil, preferredStyle: .actionSheet)
                        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                                [weak self] action in
                                self?.collectionView.reloadData()
                        }))
                        present(ac, animated: true)
                    }
                    else{
                    let ac = UIAlertController(title: "Deletar todo o conteúdo de '\(dataDevocional[indexPath.item].titulo ?? "NONE")'", message: "O conteúdo não poderá ser recuperado.", preferredStyle: .actionSheet)
                        let index = self.searchDevocional(Titulo: self.dataDevocional[indexPath.item].titulo ?? "", isSearching: false)
                        ac.addAction(UIAlertAction(title: "Deletar", style: .destructive, handler: {
                            [weak self] action in
                            try! CoreDataStack.deleteDevocional(devocionais: self!.dataDevocional[index])
                        self?.collectionView.reloadData()
                        }))
                        ac.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                        present(ac, animated: true)
                    
                    }
                    navigationController?.navigationBar.prefersLargeTitles = true
                }
            }
        }
    }
}

// MARK: Delegate
///funcoes delegate utilizadas para atualizar o conteudo da view
extension MinhaDevocionalViewController: MinhaDevocional3ViewControllerDelegate{
    func didRegister(){
        ///para a adicao
        collectionView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension MinhaDevocionalViewController: MinhaDevocional2ViewControllerDelegate{
    ///para a edicao
    func didRegisterAtt(){
        collectionView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: Search bar functions
extension MinhaDevocionalViewController: UISearchBarDelegate, UISearchResultsUpdating{
    
    
    private func configureSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        searchController.searchBar.placeholder = "Busque sua devocional..."

        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty{
            searching = true
            self.dataFiltred.removeAll() //limpando o filtro
            ///atualizar collection
            for devocional in self.dataDevocional{
                if (devocional.titulo!.lowercased().contains(searchText.lowercased())){
                    self.dataFiltred.append(devocional)
                }
            }
            //self.dataDevocional = self.dataFiltred
        }
        else {
            searching = false
            self.dataFiltred.removeAll()
            self.dataDevocional = try! CoreDataStack.getDevocional()
        }
        self.collectionView.reloadData()
    }
}

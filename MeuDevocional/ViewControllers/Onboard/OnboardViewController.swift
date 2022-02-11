//
//  OnboardViewController.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 16/01/22.
//

import Foundation


import UIKit
class OnboardViewController: UIViewController {
    
    
    var isOnboarding: Bool
    
    private lazy var closeButtonBar: UIBarButtonItem  = .init(barButtonSystemItem: .close, target: self, action: #selector(actionDismiss))
    
    //MARK: -View
    lazy var view0:ViewOnboarding =  {
        let view = ViewOnboarding(titulo: "Meu Devocional",
                   text: "Bem-vindo ao Meu Devocional, o seu espaço pessoal de leitura, reflexão e gratidão por sua Fé!",
                   imageName: "Onboard1")
        return view
    }()
    
    
    lazy var view1:ViewOnboarding =  {
        let view = ViewOnboarding(titulo: "Devocionais Diárias",
                   text: "Navegue pelas devocionais rápidas e crie suas próprias devocionais através delas. Leia devocionais diárias e anote suas reflexões em cada uma delas.",
                   imageName: "Onboard2")
        return view
    }()
    
    lazy var view2:ViewOnboarding =  {
        let view = ViewOnboarding(titulo: "Devocionais pessoais",
                   text: "Crie suas próprias devocionais, adicione a referência bíblica, músicas e compartilhe com seus amigos.",
                   imageName: "Onboard3")
        return view
    }()
    
    lazy var view3:ViewOnboarding =  {
        let view = ViewOnboarding(titulo: "Mural",
                   text: "Adicione motivos de gratidão em seu mural e transforme em widgets para o seu iPhone.",
                   imageName: "Onboard4")
        return view
    }()
    
    
    lazy var arrayViews = [view0, view1, view2, view3]
    
    //MARK: -scrollView
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(arrayViews.count), height: view.frame.height)
        
        for i in 0..<arrayViews.count {
            scrollView.addSubview(arrayViews[i])
            
            pageControl.accessibilityLabel = "Página \(i+1) de quatro"
            
            arrayViews[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
        }
        scrollView.delegate = self
    
        return scrollView
    }()
    
    //MARK: -pageControl
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = arrayViews.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor(named: "Accent")
        pageControl.pageIndicatorTintColor = UIColor(named: "Accent")?.withAlphaComponent(0.3)
        pageControl.isEnabled = false
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender:)), for: .valueChanged)
        return pageControl
    }()
    
    //MARK: -butão
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Próximo", for: .normal)
        button.backgroundColor = UIColor(named: "BackgroundOnboard")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(named: "Accent"), for: .normal)
        button.addTarget(self, action: #selector(addPageContol), for: .touchUpInside)
        
        return button
        
    }()
    
    lazy var previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Anterior", for: .normal)
        button.backgroundColor = UIColor(named: "BackgroundOnboard")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(named: "Accent"), for: .normal)
        button.addTarget(self, action: #selector(subPageContol), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
        button.backgroundColor = UIColor(named: "BackgroundOnboard")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(named: "Accent"), for: .normal)
        
        if isOnboarding {
            button.addTarget(self, action: #selector(actionNavigateViewController), for: .touchUpInside)
        } else {
            button.addTarget(self, action: #selector(actionDismiss), for: .touchUpInside)
        }
        
        
        return button
    }()
    
    //MARK: -Inits
    init(isOnboarding: Bool) {
        self.isOnboarding = isOnboarding
        super.init(nibName: nil, bundle: nil)
        setAccessibility()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //acessibilidade
        view.accessibilityViewIsModal = true
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(named: "BackgroundOnboard")
        view.addSubview(closeButton)
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        
        setupConstraints()
    }

    
    //MARK: -Constraints
    func setupConstraints(){
        
        //pagecontrol
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        let pageControlConstraints:[NSLayoutConstraint] = [
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ]
        NSLayoutConstraint.activate(pageControlConstraints)
        
        //scrollview
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let scrollViewConstraints:[NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/6),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height/3)
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)
        
        //botoes
        nextButton.translatesAutoresizingMaskIntoConstraints=false
        let nextButtonConstraints:[NSLayoutConstraint] = [
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-30)
        ]
        NSLayoutConstraint.activate(nextButtonConstraints)
        
        previousButton.translatesAutoresizingMaskIntoConstraints=false
        let previousButtonConstraints:[NSLayoutConstraint] = [
            previousButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            previousButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30)
        ]
        NSLayoutConstraint.activate(previousButtonConstraints)
        
        closeButton.translatesAutoresizingMaskIntoConstraints=false
        let closeButton:[NSLayoutConstraint] = [
            closeButton.bottomAnchor.constraint(equalTo: view.topAnchor, constant: +50),
            closeButton.leftAnchor.constraint(equalTo: view.rightAnchor,constant: -50)
        ]
        NSLayoutConstraint.activate(closeButton)
    }

    
    //MARK: -ação de mudar de pagina na pageControl
    @objc
    func pageControlTapHandler(sender: UIPageControl) {
        
        var frame: CGRect = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage )
        scrollView.scrollRectToVisible(frame, animated: true)
        
    }
    
    @objc
    func addPageContol(){
        if (scrollView.contentOffset.x+view.frame.width < view.frame.width*CGFloat(arrayViews.count)) {
            
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x+view.frame.width, y: 0), animated: false)
            
            if (scrollView.contentOffset.x+view.frame.width == view.frame.width*CGFloat(arrayViews.count)) {
                nextButton.setTitle("OK", for: .normal)
            }
            
        } else {
            //dismiss
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    @objc
    func subPageContol(){
        nextButton.setTitle("Próximo", for: .normal)
        if (scrollView.contentOffset.x-view.frame.width>=0){
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x-view.frame.width, y: 0), animated: false)
        }
        
        
    }
    
    @objc
    func actionDismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func actionNavigateViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setAccessibility(){
        closeButtonBar.isAccessibilityElement = true
        closeButtonBar.accessibilityLabel = "Fechar apresentação"
        closeButtonBar.accessibilityHint = "Clique para fechar a página de apresentação"
        
        nextButton.isAccessibilityElement = true
        nextButton.accessibilityHint = "Clique para passar para a próxima página"
        previousButton.isAccessibilityElement = true
        previousButton.accessibilityHint = "Clique para voltar uma página"
        pageControl.isAccessibilityElement = true
        pageControl.accessibilityLabel = "Controle de página"

    }
}

//MARK: -Delegate
extension OnboardViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        
        if (pageIndex != 0) {
            previousButton.isHidden = false
        }
       
        
        pageControl.currentPage = Int(pageIndex)
    }
}


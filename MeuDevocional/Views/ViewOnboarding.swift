//
//  ViewOnboard.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 16/01/22.
//

import UIKit
class ViewOnboarding:UIView{
    
    private let scrollView: UIScrollView
    public let labelTitulo = UILabel()
    public let label = UILabel()
    var imageName = String()
    
    lazy var image = UIImage(named: imageName)
    lazy var imageView = UIImageView(image: image)
    
    var font: UIFont = {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
        if let serif = descriptor.withDesign(.serif){
            return UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: UIFont(descriptor: serif, size: 0))
        }
        return UIFont(descriptor: descriptor, size: 0)
    }()
    
    var fontBody: UIFont = {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        if let rounded = descriptor.withDesign(.default){
            return UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(descriptor: rounded, size: 0))
        }
        return UIFont.init(descriptor: descriptor, size: 0)
    }()
    
    init(titulo:String,text:String,imageName:String){
        self.scrollView = UIScrollView()
        
        super.init(frame: .zero)
        self.addSubview(scrollView)
        self.backgroundColor = UIColor(named: "BackgroundOnboard")

        labelTitulo.text = titulo
        labelTitulo.numberOfLines = 0
        //labelTitulo.font = UIFont(name: "System - Light", size: 20)
        labelTitulo.font = self.font
        labelTitulo.lineBreakMode = .byTruncatingHead
        labelTitulo.textColor = UIColor(named: "Accent")
        
        scrollView.addSubview(labelTitulo)
        
        label.text = text
        label.font = self.fontBody
        label.textColor = UIColor(named: "Accent")?.withAlphaComponent(0.7)
        label.numberOfLines = 0
        scrollView.addSubview(label)
        
        self.imageName = imageName
        scrollView.addSubview(imageView)
        setupConstrainstsOnbarding()
        setAccessibility()

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstrainstsOnbarding(){
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollConstraints:[NSLayoutConstraint] = [
        scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
        scrollView.topAnchor.constraint(equalTo: self.topAnchor),
        scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -200)]
        NSLayoutConstraint.activate(scrollConstraints)

        
        labelTitulo.translatesAutoresizingMaskIntoConstraints = false
        let labelTituloConstraints:[NSLayoutConstraint] = [
            labelTitulo.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 20),
            labelTitulo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            labelTitulo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        ]
        NSLayoutConstraint.activate(labelTituloConstraints)

        label.translatesAutoresizingMaskIntoConstraints = false
        let labelConstraints:[NSLayoutConstraint] = [
            label.topAnchor.constraint(equalTo: labelTitulo.bottomAnchor,constant: 8),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            //label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(labelConstraints)
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imgConstrainsts:[NSLayoutConstraint] = [
            //imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor,multiplier: 0.3),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 4)
        ]
        
        NSLayoutConstraint.activate(imgConstrainsts)
        
        
    }
    func setAccessibility(){
        labelTitulo.isAccessibilityElement = true
        labelTitulo.accessibilityHint = "Título da página"
        label.isAccessibilityElement = true
        imageView.isAccessibilityElement = false
    }
}


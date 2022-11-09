//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Kazakov Danil on 09.11.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    
    //MARK: - ELEMENTS OF UI
    lazy var characterImage: UIImageView = {
        let characterImage = UIImageView()
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.clipsToBounds = true
        characterImage.layer.cornerRadius = 20
        
        
        return characterImage
    }()
    
    lazy var characterDescriptionLabel: UILabel = {
       let characterDescriptionLabel = UILabel()
       characterDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        characterDescriptionLabel.clipsToBounds = true
        characterDescriptionLabel.font = .systemFont(ofSize: 25, weight: .bold)
        characterDescriptionLabel.numberOfLines = 0
       
       return characterDescriptionLabel
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = "Characters"
        navigationItem.title = "About: "
        view.backgroundColor = .white
        view.addSubview(characterImage)
        view.addSubview(characterDescriptionLabel)
    }
    
    //MARK: - CONSTRAINTS
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        NSLayoutConstraint.activate([
            characterImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            characterImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            characterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
        
//        NSLayoutConstraint.activate([
//            characterDescriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
        
        NSLayoutConstraint.activate([
            characterDescriptionLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor),
            characterDescriptionLabel.leftAnchor.constraint(equalTo: characterImage.leftAnchor),
        ])
        
    }


}

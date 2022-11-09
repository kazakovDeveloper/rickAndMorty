//
//  CustomCellForCharacterView.swift
//  RickAndMorty
//
//  Created by Kazakov Danil on 09.11.2022.
//

import UIKit

struct CharacterCollectionViewCellViewModel {
    let name: String
    let characterPhoto: String
    let description: String
    let AliveStatus: String
    let location: String
}

class CustomCellForCharacterView: UICollectionViewCell {
    
    static let identifier = "CustomCellForCharacterView"
    
    private lazy var characterImageView: UIImageView = {
        let characterImageView = UIImageView()
        characterImageView.contentMode = .scaleToFill
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.layer.cornerRadius = 25
        characterImageView.clipsToBounds = true
        
        return characterImageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
    }
    
    private lazy var characterLabel: UILabel = {
       let characterLabel = UILabel()
       characterLabel.textAlignment = .left
       characterLabel.translatesAutoresizingMaskIntoConstraints = false
       characterLabel.numberOfLines = 2
       characterLabel.clipsToBounds = true
       characterLabel.font = .systemFont(ofSize: 14, weight: .bold)
       return characterLabel
    }()
    
    lazy var characterStatus: UIView = {
        let characterStatus = UIView()
        characterStatus.translatesAutoresizingMaskIntoConstraints = false
        
        characterStatus.layer.cornerRadius = 10
        characterStatus.layer.masksToBounds = true
        characterStatus.layer.borderColor = UIColor.darkGray.cgColor
        characterStatus.layer.borderWidth = 2.0
        characterStatus.backgroundColor = .red
        
        return characterStatus
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(characterImageView)
        contentView.addSubview(characterLabel)
        contentView.addSubview(characterStatus)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkAliveStatus(with viewModel:  CharacterCollectionViewCellViewModel) {
        if viewModel.AliveStatus == "Alive" {
            characterStatus.backgroundColor = .green
        } else {
            characterStatus.backgroundColor = .red
        }
    }
    
    func configure(with viewModel: CharacterCollectionViewCellViewModel) {
        
        characterLabel.text = """
                              Name: \(viewModel.name)
                              Status: \(viewModel.AliveStatus)
                              """
        
        NetworkManager.shared.fetchImage(from: viewModel.characterPhoto) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print("error \(error)")
            }
        }
        
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            characterImageView.widthAnchor.constraint(equalToConstant: 150),
            characterImageView.heightAnchor.constraint(equalToConstant: 150),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            characterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            characterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            characterLabel.leftAnchor.constraint(equalTo: characterImageView.leftAnchor),
            characterLabel.rightAnchor.constraint(equalTo: characterImageView.rightAnchor),
            characterLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            characterStatus.heightAnchor.constraint(equalToConstant: 20),
            characterStatus.widthAnchor.constraint(equalToConstant: 20),
            characterStatus.centerYAnchor.constraint(equalTo: characterLabel.centerYAnchor),
            characterStatus.rightAnchor.constraint(equalTo: characterImageView.rightAnchor)
        ])
        
    }
    
}

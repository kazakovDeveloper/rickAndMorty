//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Kazakov Danil on 09.11.2022.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var viewModels = [CharacterCollectionViewCellViewModel]()
    
    //MARK: - UI ELEMENTS
    private lazy var collectionView: UICollectionView  = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .vertical
       layout.minimumLineSpacing = 1
       layout.minimumInteritemSpacing = 1
       layout.itemSize = CGSize(
                                width: (view.frame.size.width/2)-4,
                                height: (view.frame.size.width/2)-4)
        
       let collectionView = UICollectionView(
                                            frame: .zero,
                                            collectionViewLayout: layout)
       collectionView.frame = view.bounds
       collectionView.register(
                              CustomCellForCharacterView.self,
                              forCellWithReuseIdentifier: CustomCellForCharacterView.identifier)
        
       collectionView.dataSource = self
       collectionView.delegate = self
       return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        navigationItem.title = "Rick and Morty"
        
        fetchData()
    }
    
    //MARK: - GET DATA
    func fetchData() {
        NetworkManager.shared.getCharacterData { [weak self] result in
            switch result {
            case .success(let models):
                models.results.forEach { results in
                    self?.viewModels.append(CharacterCollectionViewCellViewModel(
                                            name: results.name,
                                            characterPhoto: results.image,
                                            description: results.species,
                                            AliveStatus: results.status,
                                            location: results.location.name))
                }
            case .failure(let error):
                print("Error \(error)")
            }
        }
        
    }
    
    
    //MARK: - SETUP COLLECTION
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int)
                        -> Int {
        return viewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
                        -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCellForCharacterView.identifier,
            for: indexPath) as? CustomCellForCharacterView else {
            return UICollectionViewCell() }
        
        cell.configure(with: viewModels[indexPath.row])
        cell.checkAliveStatus(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let characterDetailsVC = CharacterDetailsViewController()
        
        let currentURL = viewModels[indexPath.row].characterPhoto        
        characterDetailsVC.characterDescriptionLabel.text = """
                                                            Раса: \(viewModels[indexPath.row].description)
                                                            Имя: \(viewModels[indexPath.row].name)
                                                            Планета: \(viewModels[indexPath.row].location)
                                                            """
        
        
        NetworkManager.shared.fetchImage(from: currentURL) { result in
            switch result {
            case .success(let characterImage):
                characterDetailsVC.characterImage.image = UIImage(data: characterImage)
            case .failure(let error):
                print("Error - \(error)")
            }
        }
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }

}


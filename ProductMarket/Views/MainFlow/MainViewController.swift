//
//  ViewController.swift
//  ProductMarket
//
//  Created by Polina on 21.12.2023.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    
    private var viewModel: CategoryViewModel
    private var cancellables = Set<AnyCancellable>()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    init(viewModel: CategoryViewModel = CategoryViewModel(networkManager: NetworkService())){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        upDateteCategory()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setConstrains()
    }
    
    //MARK: - UpdateCategory
    private func upDateteCategory(){
        viewModel.$data
            .zip(viewModel.$imageResult)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

//MARK: - Set Constrains
private extension MainViewController{
    func setConstrains(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

//MARK: - Configure UiCollectionView
private extension MainViewController{
    func configureCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PMCategoryCell.self, forCellWithReuseIdentifier: PMCategoryCell.resuseID) // register cell
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PMCategoryCell.resuseID, for: indexPath) as? PMCategoryCell else {
            return UICollectionViewCell()
        }
        cell.configCategoryLabel(categoryLabelText: viewModel.data[indexPath.row].name)
        let name = viewModel.data[indexPath.row].name
        if let nameData = viewModel.imageResult[name]{
            cell.configCategoryImage(image: UIImage(data: nameData))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryInfo = viewModel.data[indexPath.row]
        let productVC = ProductViewController(viewModel: ProductViewModel(networkManager: NetworkService(), categotyName: categoryInfo.name))
        productVC.navigationItem.title = "Продукты"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .black
        navigationController?.pushViewController(productVC, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 // from left and right of the screen
        let minimumItemSpacing: CGFloat = 11 // between columns
        let availableWidth = view.bounds.width - (padding * 2) - (minimumItemSpacing)
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: widthPerItem + 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 16, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        11
    }
}


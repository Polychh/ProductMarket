//
//  ProductViewController.swift
//  ProductMarket
//
//  Created by Polina on 24.01.2024.
//

import UIKit
import Combine

final class ProductViewController: UIViewController {
    private var viewModel: ProductViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    private let searchController = UISearchController(searchResultsController: nil)
    private let segmentControl = PMSegmentController()
    private let  busketView = BusketView()
    private let emptyView = EmptyView()
    
    private var filter: Bool = false
    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        upDateteCategory()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)]
       
        configureCollectionView()
        setUpSearchController()
        setUpSegmentController()
        setConstrains()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signOnSegmentController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - UpdateProduct
    private func upDateteCategory(){
        viewModel.$dataProduct
            .zip(viewModel.$imageResProd)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else {return}
                if !viewModel.dataProduct.isEmpty && !viewModel.imageResProd.isEmpty{
                    collectionView.reloadData()
                }
            }
            .store(in: &cancellables)
        viewModel.$filterProduct
            .zip(viewModel.$filterImageResProd)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else {return}
                guard let text = searchController.searchBar.text else {return}
                if filter || text.isEmpty{
                    collectionView.reloadData()
                }
                setupCollectionViewWhenEmpty()
            }
            .store(in: &cancellables)
    }
}
//MARK: - SetUp UI Elements
private extension ProductViewController{
    func setUpSegmentController(){
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.backgroundColor = .white
        segmentControl.chooseCategory = viewModel.categoryName
        segmentControl.createButtons(segmentArray: ["Все", "Фрукты", "Сухофрукты", "Овощи", "Зелень", "Чай кофе", "Молочные продукты"])
    }
    
    func signOnSegmentController(){
        segmentControl.$category
            .receive(on: DispatchQueue.main)
            .assign(to: \.viewModel.categoryChoosed, on: self)
            .store(in: &cancellables)
        segmentControl.$isChangedSeg
            .receive(on: DispatchQueue.main)
            .assign(to: \.viewModel.isChanged, on: self)
            .store(in: &cancellables)
    }
    
    func setUpSearchController(){
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Быстрый поиск"
        searchController.searchBar.searchTextField.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupCollectionViewWhenEmpty() {
        collectionView.backgroundView = (viewModel.filterProduct.isEmpty && filter) ? emptyView : nil
      }
}


//MARK: - Set Constrains
private extension ProductViewController{
    func setConstrains(){
        view.addSubview(collectionView)
        view.addSubview(segmentControl)
        busketView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(busketView)
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentControl.heightAnchor.constraint(equalToConstant: 27),

            collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor,constant: 24),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            busketView.heightAnchor.constraint(equalToConstant: 48),
            busketView.widthAnchor.constraint(equalToConstant: 168),
            busketView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            busketView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
    }
}

//MARK: - Configure UiCollectionView
private extension ProductViewController{
    func configureCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PMProductCell.self, forCellWithReuseIdentifier: PMProductCell.resuseID) // register cell
    }
}
//MARK: - SearchController
extension ProductViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        if text.isEmpty{
            self.filter = false
            viewModel.filterProduct = []
            viewModel.filterImageResProd = [:]
        }else{
            self.filter = true
            self.viewModel.filterProduct = self.viewModel.dataProduct.filter({ $0.title.contains(text) })
            self.viewModel.filterImageResProd = self.viewModel.imageResProd.filter({ $0.key.contains(text) })
        }
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // dismiss keyBoard
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filter ? viewModel.filterProduct.count : viewModel.dataProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PMProductCell.resuseID, for: indexPath) as? PMProductCell else {
            return UICollectionViewCell()
        }
        let data = filter ? viewModel.filterProduct[indexPath.row] : viewModel.dataProduct[indexPath.row]
        let imageTitle = filter ? viewModel.filterProduct[indexPath.row].title : viewModel.dataProduct[indexPath.row].title
        if let image = viewModel.imageResProd[imageTitle]{
            cell.configProductImage(image: UIImage(data: image))
        }
        cell.configProductLabel(productText: data.title)
        cell.configPricetLabel(price: data.price)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchController.dismiss(animated: false) {
            let detailVC = ProductCardDetailVC()
            let data = self.filter ? self.viewModel.filterProduct[indexPath.row] : self.viewModel.dataProduct[indexPath.row]
            let imageTitle = self.filter ? self.viewModel.filterProduct[indexPath.row].title : self.viewModel.dataProduct[indexPath.row].title
            if let image = self.viewModel.imageResProd[imageTitle]{
                detailVC.configProductImage(image: UIImage(data: image))
            }
            detailVC.configProductLabel(productText: data.title)
            detailVC.configPricetLabel(price: data.price)
            detailVC.configDescriptLabel(descText: data.description)
            detailVC.modalPresentationStyle = .overCurrentContext
            self.present(detailVC, animated: true)
          }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 // from left and right of the screen
        let minimumItemSpacing: CGFloat = 11 // between columns
        let availableWidth = view.bounds.width - (padding * 2) - (minimumItemSpacing)
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: widthPerItem + 62)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        11
    }
}

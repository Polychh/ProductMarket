//
//  PMSegmentController.swift
//  ProductMarket
//
//  Created by Polina on 25.01.2024.
//

import UIKit

final class PMSegmentController: UIView, ObservableObject {
    
    var chooseCategory: String = ""
    //@Published var isChangedSeg = false
    @Published var category: String = ""
    private let color = #colorLiteral(red: 0.8571347594, green: 0.8542680144, blue: 0.8668256402, alpha: 1)
    
    private let scrollViewHor: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.alwaysBounceHorizontal = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstrains()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createButtons(segmentArray: [String]){
        segmentArray.enumerated().forEach{ index, element in
            let button = UIButton()
            setUpColorChoosedCategory(button: button, category: element, choosedCategory: chooseCategory)
            setUpButton(button: button, category: element, index: index)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func setUpButton(button: UIButton, category: String, index: Int){
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 27).isActive = true
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle(category, for: .normal)
        button.tag = index
        button.addTarget(nil, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func setUpColorChoosedCategory(button: UIButton, category: String, choosedCategory: String){
        if category == chooseCategory {
            button.backgroundColor = Const.colorGreen
            button.setTitleColor(.white, for: .normal)
        } else{
            button.backgroundColor = color
            button.setTitleColor(.lightGray, for: .normal)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        changeColorTextBack(tag: sender.tag)
    }
    
    private func changeColorTextBack(tag: Int) {
        stackView.arrangedSubviews.forEach {
            if let button = $0 as? UIButton {
                if button.tag == tag {
                    if let text = button.titleLabel?.text{
                        //isChangedSeg = true
                        category = text
                    }
                    button.backgroundColor = Const.colorGreen
                    button.setTitleColor(.white, for: .normal)
                } else {
                    button.backgroundColor = color
                    button.setTitleColor(.lightGray, for: .normal)
                }
            }
        }
    }
}

//MARK: - Constrains
extension PMSegmentController{
    private func setConstrains(){
        addSubview(scrollViewHor)
        scrollViewHor.addSubview(stackView)
        NSLayoutConstraint.activate([
            scrollViewHor.topAnchor.constraint(equalTo: topAnchor),
            scrollViewHor.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollViewHor.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollViewHor.heightAnchor.constraint(equalToConstant: 27),

            
            stackView.leadingAnchor.constraint(equalTo: scrollViewHor.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollViewHor.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollViewHor.heightAnchor),
        ])
    }
}

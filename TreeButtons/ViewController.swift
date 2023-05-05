//
//  ViewController.swift
//  TreeButtons
//
//  Created by Svetlana Shardakova on 04.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private enum Constants {
        static let firstButtonText: String = "First Button"
        static let secondButtonText: String = "Second Medium Button"
        static let thirdButtonText: String = "Third"
        static let buttonImage: UIImage = UIImage(systemName: "arrowshape.turn.up.right.circle.fill") ?? UIImage().withTintColor(.white, renderingMode: .alwaysOriginal)
        //corner
    }
    
    lazy var firstButton: RoundedButton = {
        let button = RoundedButton(title: Constants.firstButtonText, image: Constants.buttonImage)
        return button
    }()
    
    lazy var secondButton: RoundedButton = {
        let button = RoundedButton(title: Constants.secondButtonText, image: Constants.buttonImage)
        return button
    }()
    
    lazy var thirdButton: RoundedButton = {
        let button = RoundedButton(title: Constants.thirdButtonText, image: Constants.buttonImage)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
//        setupUI()
        setupPositions()
    }
    func setupSubviews() {
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
    }
    
    func setupPositions() {
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.centerYAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 40),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.centerYAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 40)
        ])
    }


//    private func setupUI() {
//        firstButton.setTitle("Test1", for: .normal)
//    }

}


class RoundedButton: UIButton {
    
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? CGSize.zero
        let desiredButtonSize = CGSize(width: labelSize.width + contentEdgeInsets.left + contentEdgeInsets.right,
                                       height: labelSize.height + contentEdgeInsets.top + contentEdgeInsets.bottom)
        return desiredButtonSize
    }
    
    init(title: String, image: UIImage) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        initialSetup()
        backgroundColor = .magenta
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialSetup() {
        setCorners()
        setContentInsets()
    }
    
    func setCorners() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func setContentInsets() {
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        if let titleLabel = titleLabel {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -titleLabel.frame.width - 8)
        }
        if let imageView = imageView {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageView.frame.width, bottom: 0, right: imageView.frame.width)
        }
        sizeToFit()
    }

}

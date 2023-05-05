//
//  RoundedButton.swift
//  TreeButtons
//
//  Created by Svetlana Shardakova on 06.05.2023.
//

import UIKit

class RoundedButton: UIButton {
    
    private enum Constants {
        static let contentColor: UIColor = .magenta
        static let cornerRadius: CGFloat = 10
        static let horizontalInset: CGFloat = 14
        static let verticalInset: CGFloat = 10
        static let imageInset: CGFloat = 8
        static let animationDuration: TimeInterval = 2
    }

    private var originalSize: CGSize?
    private var isShrinking: Bool = false
    
    override func layoutSubviews() {
        contentEdgeInsets = UIEdgeInsets(top: Constants.verticalInset, left: Constants.horizontalInset, bottom: Constants.verticalInset, right: Constants.horizontalInset)
        if let titleLabel = titleLabel, let imageView = imageView {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleLabel.frame.size.width + 8, bottom: 0, right: -titleLabel.frame.size.width)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageView.frame.size.width, bottom: 0, right: imageView.frame.size.width + 8)
        }
        super.layoutSubviews()
    }
    
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? CGSize.zero
        let desiredButtonSize = CGSize(width: labelSize.width + Constants.horizontalInset + Constants.horizontalInset + Constants.imageInset + (imageView?.image?.size.width ?? 0),
                                       height: max(labelSize.height, (imageView?.image?.size.height ?? 0)) + Constants.verticalInset + Constants.verticalInset)
        return desiredButtonSize
    }
    
    init(title: String, image: UIImage) {
        super.init(frame: .zero)
    
        initialSetup(title: title, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup(title: String, image: UIImage) {
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        backgroundColor = Constants.contentColor
        
        setCorners()
        setContentInsets()
    }
    
    func setCorners() {
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
    }
    
    func setContentInsets() {

    }

}

//MARK: - Touches
extension RoundedButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else { return }
        guard !isShrinking else { return }
        originalSize = self.bounds.size
        UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
            guard let self = self else { return }
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        })
        
        isShrinking = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let originalSize = originalSize else { return }
        
        if isShrinking {
            // Animate the button to return to original size
            UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
                guard let self = self else { return }
                self.transform = .identity
            })
        } else {
            // Perform the button's action
            self.sendActions(for: .touchUpInside)
        }
        
        self.originalSize = nil
        isShrinking = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        guard let originalSize = originalSize else { return }
        guard isShrinking else { return }
        
        // Animate the button to return to original size
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else { return }
            self.transform = .identity
        })
        
        self.originalSize = nil
        isShrinking = false
    }
}

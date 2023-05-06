//
//  RoundedButton.swift
//  TreeButtons
//

import UIKit

class RoundedButton: UIButton {
    
    private enum Constants {
        static let normalColor: UIColor = .magenta
        static let dimmedColor: UIColor = .lightGray
        static let cornerRadius: CGFloat = 10
        static let horizontalInset: CGFloat = 14
        static let verticalInset: CGFloat = 10
        static let imageInset: CGFloat = 8
        static let animationDuration: TimeInterval = 2
        static let animationScale: CGFloat = 0.5
    }

    private var longPressGestureRecognizer: UILongPressGestureRecognizer?
    
    override func layoutSubviews() {
        contentEdgeInsets = UIEdgeInsets(top: Constants.verticalInset, left: Constants.horizontalInset, bottom: Constants.verticalInset, right: Constants.horizontalInset)
        if let titleLabel = titleLabel, let imageView = imageView {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleLabel.frame.size.width + Constants.imageInset, bottom: 0, right: -titleLabel.frame.size.width)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageView.frame.size.width, bottom: 0, right: imageView.frame.size.width + Constants.imageInset)
        }
        super.layoutSubviews()
    }
    
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? CGSize.zero
        let desiredWidth = labelSize.width + Constants.horizontalInset + Constants.horizontalInset + Constants.imageInset + (imageView?.image?.size.width ?? 0)
        let desiredHeight = max(labelSize.height, (imageView?.image?.size.height ?? 0)) + Constants.verticalInset + Constants.verticalInset
        let desiredButtonSize = CGSize(width: desiredWidth, height: desiredHeight)
        return desiredButtonSize
    }

    override func tintColorDidChange() {
         super.tintColorDidChange()
        
        switch tintAdjustmentMode {
        case .normal :
            self.backgroundColor = Constants.normalColor
        case .automatic:
            break
        case .dimmed:
            self.backgroundColor = Constants.dimmedColor
        @unknown default:
            break
        }
    }

    init(title: String, image: UIImage) {
        super.init(frame: .zero)

        initialSetup(title: title, image: image)
        setupLongPressGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MARK: - Appearance

private extension RoundedButton {

    func initialSetup(title: String, image: UIImage) {
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        backgroundColor =  Constants.normalColor
        tintAdjustmentMode = .automatic
        
        setCorners()
    }
    
    func setCorners() {
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
    }
}

//MARK: - Touches

private extension RoundedButton {
    
    func setupLongPressGestureRecognizer() {
        self.longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        self.addGestureRecognizer(self.longPressGestureRecognizer!)
    }
    
    @objc
    func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
         switch gestureRecognizer.state {
         case .began:
             self.startAnimation()
         case .ended, .cancelled:
             self.stopAnimation()
         default:
             break
         }
     }

    func startAnimation() {
        UIView.animate(withDuration: Constants.animationDuration, delay: 0, options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState], animations: {
            self.transform = CGAffineTransform(scaleX: Constants.animationScale, y: Constants.animationScale)
        } )
    }

    func stopAnimation() {
        UIView.animate(withDuration: Constants.animationDuration, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.transform = .identity
        })
    }
    
}

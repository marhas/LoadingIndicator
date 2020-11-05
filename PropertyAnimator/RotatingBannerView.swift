//
//  RotatingBannerView.swift
//  PropertyAnimator
//
//  Created by Marcel Hasselaar on 2020-11-05.
//

import UIKit

class RotatingBannerView: UIView {

    init(image: UIImage) {
        self.image = image
        super.init(frame: CGRect.zero)
        setup()
    }

    required init?(coder: NSCoder) {
        self.image = UIImage(named: "monochrome_gradient-6")!
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        let imageViewOne = UIImageView(image: image)
        imageViewOne.contentMode = .scaleToFill
        imageViewOne.translatesAutoresizingMaskIntoConstraints = false
        let imageViewTwo = UIImageView(image: image)
        imageViewTwo.contentMode = .scaleToFill
        imageViewTwo.translatesAutoresizingMaskIntoConstraints = false

        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.addSubview(imageViewOne)
        progressView.addSubview(imageViewTwo)

        imageViewOne.leftAnchor.constraint(equalTo: progressView.leftAnchor).isActive = true
        imageViewOne.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        imageViewOne.heightAnchor.constraint(equalTo: progressView.heightAnchor).isActive = true

        imageViewTwo.leftAnchor.constraint(equalTo: imageViewOne.rightAnchor).isActive = true
        imageViewTwo.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        imageViewTwo.rightAnchor.constraint(equalTo: progressView.rightAnchor).isActive = true
        imageViewTwo.widthAnchor.constraint(equalTo: imageViewOne.widthAnchor).isActive = true
        imageViewTwo.heightAnchor.constraint(equalTo: imageViewOne.heightAnchor).isActive = true

        addSubview(progressView)
        NSLayoutConstraint.activate([progressViewCenterConstraint])
        progressView.verticallyBound(inside: self)
        progressView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2).isActive = true

        startAnimating()
    }

    private func startAnimating() {
        centerXOffset = self.startOffset
        layoutIfNeeded()
        centerXOffset = self.endOffset
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.layoutIfNeeded()
        }, completion: { animationPosition in
            self.startAnimating()
        })
    }

    private var startOffset: CGFloat {
        progressView.bounds.width * 0.25
    }

    private var endOffset: CGFloat {
        -progressView.bounds.width * 0.25
    }

    private var centerXOffset: CGFloat = 0 {
        didSet {
            progressViewCenterConstraint.constant = centerXOffset
        }
    }

    lazy var progressViewCenterConstraint: NSLayoutConstraint = {
        let centerConstraint = progressView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: startOffset)
        centerConstraint.isActive = true
        return centerConstraint
    }()

    private var animator: UIViewPropertyAnimator?
    private let progressView = UIView()
    private let image: UIImage
}


extension UIView {
    func horizontallyCentered(in other: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: other.centerXAnchor).isActive = true
    }

    func verticallyCentered(in other: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: other.centerYAnchor).isActive = true
    }

    func centered(in other: UIView) {
        verticallyCentered(in: other)
        horizontallyCentered(in: other)
    }

    func verticallyBound(inside other: UIView, topInset: CGFloat = 0, bottomInset: CGFloat = 0, considerSafeArea: Bool = true) {
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *), considerSafeArea {
            topAnchor.constraint(equalTo: other.safeAreaLayoutGuide.topAnchor, constant: topInset).isActive = true
        } else {
            topAnchor.constraint(equalTo: other.topAnchor, constant: topInset).isActive = true
        }

        if #available(iOS 11.0, *), considerSafeArea {
            bottomAnchor.constraint(equalTo: other.safeAreaLayoutGuide.bottomAnchor, constant: -bottomInset).isActive = true
        } else {
            bottomAnchor.constraint(equalTo: other.bottomAnchor, constant: -bottomInset).isActive = true
        }
    }

    func horizontallyBound(inside other: UIView, leftInset: CGFloat = 0, rightInset: CGFloat = 0, considerSafeArea: Bool = true) {
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *), considerSafeArea {
            leftAnchor.constraint(equalTo: other.safeAreaLayoutGuide.leftAnchor, constant: leftInset).isActive = true
        } else {
            leftAnchor.constraint(equalTo: other.leftAnchor, constant: leftInset).isActive = true
        }

        if #available(iOS 11.0, *), considerSafeArea {
            rightAnchor.constraint(equalTo: other.safeAreaLayoutGuide.rightAnchor, constant: -rightInset).isActive = true
        } else {
            rightAnchor.constraint(equalTo: other.rightAnchor, constant: -rightInset).isActive = true
        }
    }

    func bound(inside other: UIView, withInsets insets: UIEdgeInsets = UIEdgeInsets.zero, considerSafeArea: Bool = true) {
        verticallyBound(inside: other, topInset: insets.top, bottomInset: insets.bottom, considerSafeArea: considerSafeArea)
        horizontallyBound(inside: other, leftInset: insets.left, rightInset: insets.right, considerSafeArea: considerSafeArea)
    }
}

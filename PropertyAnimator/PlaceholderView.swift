//
//  PlaceholderView.swift
//  PropertyAnimator
//
//  Created by Marcel Hasselaar on 2020-11-05.
//

import UIKit

class PlaceholderView: UIView {

    init() {
        super.init(frame: CGRect.zero)
        loadViewFromNib()
    }

    override var bounds: CGRect {
        didSet {
            updateCornerRadius()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
    }

    private func loadViewFromNib() {
        Bundle.main.loadNibNamed("PlaceholderView", owner: self)
        addSubview(view)
        view.bound(inside: self)
    }

    override func awakeFromNib() {
        updateCornerRadius()
    }

    private func updateCornerRadius() {
        placeholdersToBeSlightlyRounded.forEach {
            $0.layer.cornerRadius = 4
        }
        placeholdersToBeRound.forEach {
            $0.layer.cornerRadius = $0.bounds.size.height / 2
        }
    }

    @IBOutlet var placeholdersToBeSlightlyRounded: [UIView]!
    @IBOutlet var placeholdersToBeRound: [UIView]!
    @IBOutlet var view: UIView!
}

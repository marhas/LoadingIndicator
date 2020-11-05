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

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
    }

    private func loadViewFromNib() {
        guard subviews.count == 0 else { return }
        Bundle.main.loadNibNamed("PlaceholderView", owner: self)
        addSubview(view)
        view.bound(inside: self)
    }

    override func awakeFromNib() {
        updateCornerRadius()
    }

    private func updateCornerRadius() {
        roundedPlaceholders.forEach {
            $0.layer.cornerRadius = 4
        }
    }

    @IBOutlet var roundedPlaceholders: [RotatingBannerView]!
    @IBOutlet var view: UIView!
}

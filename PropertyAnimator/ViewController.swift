//
//  ViewController.swift
//  PropertyAnimator
//
//  Created by Marcel Hasselaar on 2020-11-04.
//

import UIKit

// One placeholder is created in Storyboard and one from code for demo purposes

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let placeholderView = PlaceholderView()
        view.addSubview(placeholderView)
        placeholderView.horizontallyBound(inside: view)
        placeholderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        placeholderView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

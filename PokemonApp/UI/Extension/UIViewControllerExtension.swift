//
//  UIViewControllerExtension.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 30/07/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(to view: UIView, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: constant),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: constant),
        ])
    }
    
    static func getSize(width: CGFloat = UIScreen.main.bounds.width,
                        text: String?,
                        titleInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                        font: UIFont = .systemFont(ofSize: 47, weight: .bold)) -> CGSize {
        let labelVMargins: CGFloat =  titleInsets.top + titleInsets.bottom
        let labelHMargins: CGFloat =  titleInsets.left + titleInsets.right
        let labelHeight: CGFloat = text?.height(withConstrainedWidth: (width - labelHMargins),
                                                font: font) ?? 0
        
        
        return CGSize(width: width, height: labelHeight + labelVMargins)
    }
}

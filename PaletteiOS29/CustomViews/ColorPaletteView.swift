//
//  ColorPaletteView.swift
//  PaletteiOS29
//
//  Created by Maxwell Poffenbarger on 2/11/20.
//  Copyright © 2020 Darin Armstrong. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {
    
    //MARK: - Properties
    var colors: [UIColor] {
        didSet {
            buildColorBricks()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpViews()
    }
    
    init(colors: [UIColor] = [], frame: CGRect = .zero) {
        self.colors = colors
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("coder has not been implemented")
    }
    
    //MARK: - Create Subviews
    lazy var colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private func setUpViews() {
        addSubview(colorStackView)
        colorStackView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, topPadding: 0, bottomPadding: 0, leadingPadding: 0, trailingPadding: 0)
        buildColorBricks()
    }
    
    private func generateColorBrick(for color: UIColor) -> UIView {
        let colorBrick = UIView()
        colorBrick.backgroundColor = color
        
        return colorBrick
    }
    
    private func resetColorBricks() {
        for subview in colorStackView.arrangedSubviews {
            self.colorStackView.removeArrangedSubview(subview)
        }
    }
    
    private func buildColorBricks() {
        resetColorBricks()
        for color in self.colors {
            let colorBrick = generateColorBrick(for: color)
            self.addSubview(colorBrick)
            self.colorStackView.addArrangedSubview(colorBrick)
        }
    }
    
}//End of class


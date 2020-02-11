//
//  PaletteTableViewCell.swift
//  PaletteiOS29
//
//  Created by Maxwell Poffenbarger on 2/11/20.
//  Copyright © 2020 Darin Armstrong. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var photo: UnsplashPhoto? {
        didSet {
            updateViews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    
    //MARK: - Class Methods
    func updateViews() {
        guard let photo = photo else {return}
        fetchImage(photo: photo)
        fetchColors(photo: photo)
        paletteTitleLabel.text = photo.description
        
    }
    
    func setupViews() {
        self.addSubview(paletteImageView)
        self.addSubview(paletteTitleLabel)
        self.addSubview(colorPaletteView)
        
        let imageDimensions = (contentView.frame.width - (spacingConstants.outerHorizontalPadding * 2))
        
        
        paletteImageView.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: spacingConstants.outerVerticalPadding, bottomPadding: 0, leadingPadding: spacingConstants.outerHorizontalPadding, trailingPadding: spacingConstants.outerHorizontalPadding, width: imageDimensions, height: imageDimensions)
        
        paletteTitleLabel.anchor(top: paletteImageView.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: spacingConstants.verticalObjectBuffer, bottomPadding: 0, leadingPadding: spacingConstants.outerHorizontalPadding, trailingPadding: spacingConstants.outerHorizontalPadding, width: nil, height: spacingConstants.oneLineElementHeight)
        
        colorPaletteView.anchor(top: paletteTitleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: spacingConstants.verticalObjectBuffer, bottomPadding: spacingConstants.outerVerticalPadding, leadingPadding: spacingConstants.outerHorizontalPadding, trailingPadding: spacingConstants.outerHorizontalPadding, width: nil, height: spacingConstants.twoLineElementHeight)
        
        colorPaletteView.clipsToBounds = true
        colorPaletteView.layer.cornerRadius = (spacingConstants.twoLineElementHeight / 2)
    }
    
    func fetchImage(photo: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: photo) { (image) in
            DispatchQueue.main.async {
                self.paletteImageView.image = image
            }
        }
    }
    
    func fetchColors (photo: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: photo.urls.regular) { (colors) in
            DispatchQueue.main.async {
                guard let colors = colors else {return}
                self.colorPaletteView.colors = colors
            }
        }
    }
    
    //MARK: - Create Subviews
    lazy var paletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = (contentView.frame.height/20)
        
        return imageView
    }()
    
    lazy var paletteTitleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var colorPaletteView: ColorPaletteView = {
        let paletteView = ColorPaletteView()
        return paletteView
    }()
}//End of class

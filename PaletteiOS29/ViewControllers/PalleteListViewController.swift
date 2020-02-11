//
//  PalleteListViewController.swift
//  PaletteiOS29
//
//  Created by Maxwell Poffenbarger on 2/11/20.
//  Copyright © 2020 Darin Armstrong. All rights reserved.
//

/*
 Step 1 - Declare our views
 Step 2 - Add our subviews to our superview
 Step 3 - Constrain our views
 */

import UIKit

class PalleteListViewController: UIViewController {
    
    //MARK: - Properties
    var photos: [UnsplashPhoto] = []
    
    var buttons: [UIButton] {
        return [featureButton, doubleRainbowButton, randomButton]
    }
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    //MARK: - Lifeycle
    override func loadView() {
        super.loadView()
        addAllSubViews()
        setupStackView()
        constrainViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        searchForCategory(.featured)
        activateButtons()
        selectButton(featureButton)
    }
    
    func searchForCategory(_ route: UnsplashRoute) {
        UnsplashService.shared.fetchFromUnsplash(for: route) { (photos) in
            DispatchQueue.main.async {
                guard let photos = photos else {return}
                self.photos = photos
                self.paletteTableView.reloadData()
            }
        }
    }
    
    //MARK: - Create Subviews
    let featureButton: UIButton = {
        let button = UIButton()
        button.setTitle("Featured", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let doubleRainbowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Double Rainbow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        return stackView
    }()
    
    let paletteTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    //MARK: - subviews
    func addAllSubViews() {
        self.view.addSubview(featureButton)
        self.view.addSubview(doubleRainbowButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(paletteTableView)
    }
    
    func setupStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(featureButton)
        buttonStackView.addArrangedSubview(doubleRainbowButton)
        buttonStackView.addArrangedSubview(randomButton)
    }
    
    func configureTableView() {
        paletteTableView.delegate = self
        paletteTableView.dataSource = self
        
        paletteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "paletteCell")
        paletteTableView.allowsSelection = false
    }
    
    //MARK: - Constrain Views
    func constrainViews() {
        buttonStackView.anchor(top: self.safeArea.topAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, topPadding: 0, bottomPadding: 0, leadingPadding: 8, trailingPadding: 8)
        
        paletteTableView.anchor(top: buttonStackView.bottomAnchor, bottom: self.safeArea.bottomAnchor, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, topPadding: (buttonStackView.frame.height/2), bottomPadding: 0, leadingPadding: 0, trailingPadding: 0)
    }
    
    //MARK: - Actions
    func activateButtons() {
        buttons.forEach {$0.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside)}
    }
    
    @objc func searchButtonTapped(sender: UIButton) {
        selectButton(sender)
        switch sender {
        case randomButton:
            searchForCategory(.random)
        case doubleRainbowButton:
            searchForCategory(.doubleRainbow)
        case featureButton:
            searchForCategory(.featured)
        default:
            print("error, button not found")
        }
    }
    
    func selectButton(_ button: UIButton) {
        buttons.forEach {$0.setTitleColor((UIColor(named: "offWhite")), for: .normal)}
        button.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
    }
    
}//End of class

//MARK: - Table View
extension PalleteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "paletteCell", for: indexPath) as? PaletteTableViewCell else {return UITableViewCell()}
        
        let photo = photos[indexPath.row]
        
        cell.photo = photo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageViewSpace: CGFloat = (view.frame.width - (2 * spacingConstants.outerHorizontalPadding))
        let textLabelSpace: CGFloat = spacingConstants.oneLineElementHeight
        let colorPalleteSpacing: CGFloat = spacingConstants.twoLineElementHeight
        let outerVerticalSpacing: CGFloat = (2 * spacingConstants.outerVerticalPadding)
        let innerVerticalSpacing: CGFloat = (2 * spacingConstants.verticalObjectBuffer)
        
        return imageViewSpace + textLabelSpace + colorPalleteSpacing + outerVerticalSpacing + innerVerticalSpacing
    }
}//End of extension

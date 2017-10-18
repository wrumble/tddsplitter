//
//  CarouselView.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class BillCarouselView: UIView {
    
    private var bill: Bill!
    
    private let nameLabel = CarouselLabel()
    private let locationLabel = CarouselLabel()
    private let dateLabel = CarouselLabel()
    let splitButton = CarouselButton()
    private let tableView = UITableView()
    
    required init(bill: Bill) {
        super.init(frame: .zero)
        
        self.bill = bill
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupHierarchy() {
        addSubview(nameLabel)
        addSubview(locationLabel)
        addSubview(dateLabel)
        addSubview(tableView)
        addSubview(splitButton)
    }
    
    private func setupViews() {
        accessibilityIdentifier = AccesID.carouselView
        isUserInteractionEnabled = true
        layer.cornerRadius = Layout.carouselViewCornerRadius
        backgroundColor = Color.carouselView
        
        nameLabel.text = bill.name
        nameLabel.textAlignment = .center
        nameLabel.accessibilityIdentifier = AccesID.carouselNameLabel
        
        locationLabel.text = bill.location
        locationLabel.textAlignment = .left
        locationLabel.accessibilityIdentifier = AccesID.carouselLocationLabel
        
        dateLabel.text = bill.creationDate
        dateLabel.font = Font.carouselDateText
        dateLabel.textAlignment = .right
        dateLabel.accessibilityIdentifier = AccesID.carouselDateLabel
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = CarouselTableViewDataSource(items: bill.items!)
        
        let buttonTitle = "Split £\(bill.totalPrice())"
        splitButton.setTitle(buttonTitle, for: .normal)
    }
    
    private func setupLayout() {
        nameLabel.pinToSuperview(edges: [.top, .left, .right])
        
        locationLabel.pinToSuperview(edges: [.left],
                                     constant: Layout.spacer,
                                     priority: .required)
        locationLabel.pinTop(to: nameLabel, anchor: .bottom)
        locationLabel.pinRight(to: dateLabel, anchor: .left)
        
        dateLabel.pinToSuperview(edges: [.right],
                                 constant: -Layout.spacer,
                                 priority: .required)
        dateLabel.pinTop(to: nameLabel, anchor: .bottom)
        
        tableView.pinTop(to: locationLabel, anchor: .bottom)
        tableView.pinToSuperview(edges: [.left, .right])
        tableView.pinBottom(to: splitButton, anchor: .top)
        
        splitButton.pinToSuperview(edges: [.left, .right, .bottom])
    }
}

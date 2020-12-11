//
//  ViewController.swift
//  DropDown
//
//  Created by Jawad Ali on 27/11/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

enum TransactionFilter: String,CaseIterable {
    case allTransactions = "All Transactions"
    case processed = "Processed"
    case availableForPickup = "Available for Pickup"
    case orderCollected = "Order collected"
}

class ViewController: UIViewController {
    
    private lazy var navigationButton:NavigationButton = {
        let button = NavigationButton(navigationController: self.navigationController)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var filterPopup: DropDownViewController = {
        let popup = DropDownViewController(items:items , selectedIndex: selectedIndex)
        popup.transitioningDelegate = popup.presentationManager
        popup.modalPresentationStyle = .custom
        return popup
    }()
    
   private let items = TransactionFilter.allCases.map{ $0.rawValue }
  private  var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationButton.buttonTitle = TransactionFilter.allCases.first?.rawValue ?? ""
        self.navigationItem.titleView = navigationButton
    }
    
    @objc func tapped() {
        present(filterPopup, animated: true)
        
        filterPopup.action = { [weak self] index in
            guard let self = self else { return }
            self.selectedIndex = index
            self.navigationButton.buttonTitle = self.items[index]
            switch TransactionFilter(rawValue: self.items[index] ) {
            case .allTransactions:
                print("alll")
            case .availableForPickup:
                print("pickup")
            default:
                print("other")
            }
        }
        
        filterPopup.animationBlock = { [weak self] direction in
            self?.navigationButton.direction = direction
        }
    }
    
}


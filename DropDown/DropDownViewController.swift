//
//  DropDownViewController.swift
//  DropDown
//
//  Created by Jawad Ali on 27/11/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

protocol AlertPopupBase {
    var alertSize: CGSize { get }
}

public typealias AnimationBlock = (Direction) -> Void
public typealias ActionBlock = ((Int) -> Void)
public class DropDownViewController: UITableViewController,AlertPopupBase {
    
    //MARK:- Public properties
    
    /// items takes `string` array to show in `tableView`
    public var items: [String] {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }
    
    /// action block and animation block are `callbacks closures`
    public var action: ActionBlock?
    public var animationBlock: AnimationBlock?
    
    private var selectedIndex: Int?
    
    /// alertSize set `preferredContentSize` for the controller
    var alertSize: CGSize = .zero {
        didSet {
            preferredContentSize = alertSize
        }
    }
    
    // MARK: Initialization
    public required init(items:[String], selectedIndex:Int? = nil) {
        if let index = selectedIndex {
            precondition(index < items.count)
        }
        self.items = items
        self.selectedIndex = selectedIndex
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var presentationManager = PopupPresentationManager()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
         tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
       
        alertSize = CGSize(width: UIScreen.main.bounds.width*0.65, height: CGFloat( items.count*50))
        
        view.layer.cornerRadius = 20
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.masksToBounds = false
        view.backgroundColor = .white
    
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 1)))
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  
        tableView.reloadData()
       
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationBlock?(.up)
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animationBlock?(.down)
    }
    
     func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
//MARK:- DimmingViewTappedProtocol for dismissal
extension DropDownViewController: DimmingViewTappedProtocol {}

//MARK:- TableView DataSource and Delegates
extension DropDownViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public override func tableView(_ tableView: UITableView,
                                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let previousIndexPath = IndexPath(row: selectedIndex ?? 0, section: 0)
        selectedIndex = indexPath.row
        let selectedIndexPath = IndexPath(row: indexPath.row, section: 0)
        
        tableView.reloadRows(at: [previousIndexPath, selectedIndexPath], with: .none)
        
        action?(indexPath.row)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.dismiss()
        }
        
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell
        cell?.config(item: items[indexPath.row], isSelected: selectedIndex == indexPath.row)
        return cell ?? UITableViewCell()
        
    }
}

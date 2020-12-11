//
//  TableViewCell.swift
//  DropDown
//
//  Created by Jawad Ali on 28/11/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

public class TableViewCell: UITableViewCell,ReusableView {

     // MARK: Views
    private lazy var stack: UIStackView = UIStackViewFactory.createStackView(with: .horizontal, alignment: .center, distribution: .fill, spacing: 5, arrangedSubviews: [title,selectIcon])
    
    private lazy var title: UILabel = UILabelFactory.createUILabel(with: .black, font: UIFont.preferredFont(forTextStyle: .body), alignment: .left, numberOfLines: 0, lineBreakMode: .byWordWrapping)
    
    private lazy var selectIcon = UIImageViewFactory.createImageView(mode: .center, image: UIImage.init(named: "Check"))

    
    // MARK: Initialization
     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         commonInit()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         commonInit()
     }
     
     private func commonInit() {
         selectionStyle = .none
         
         setupViews()
         setupConstraints()
     }
}

// MARK: View setup

private extension TableViewCell {
    func setupViews() {
        contentView.addSubview(stack)
        backgroundColor = .clear
    }
    
    func setupConstraints() {
        
        stack
            .alignEdgesWithSuperview([.left, .right, .top, .bottom], constants:[20, 20, 10, 10])

        selectIcon
            .height(constant: 24)
            .width(constant: 24)
    }
}

//MARK:- configure
public extension TableViewCell {
    func config(item:String, isSelected:Bool) {
        title.text = item
        selectIcon.isHidden = !isSelected
    }
}

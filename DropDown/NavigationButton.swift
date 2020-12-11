//
//  NavigationButton.swift
//  DropDown
//
//  Created by Jawad Ali on 28/11/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
public enum Direction {
    case up
    case down
}

public class NavigationButton: UIControl {

    //MARK:- Public properties
    public var direction: Direction {
        didSet {
            self.downArrowImageView.transform = direction == .up
            ? CGAffineTransform(rotationAngle: CGFloat.pi) : CGAffineTransform.identity
        }
    }
    
    public var buttonTitle: String {
        didSet {
            titleLabel.text = buttonTitle
        }
    }
    
    //MARK:- Views
     lazy var titleStack = UIStackViewFactory.createStackView(with: .horizontal, alignment: .center, distribution: .fill, spacing: 5, arrangedSubviews: [titleLabel,downArrowImageView])
       
    private lazy var titleLabel = UILabelFactory.createUILabel(with: .black, font: UIFont.preferredFont(forTextStyle: .headline))
       
    private lazy var downArrowImageView  = UIImageViewFactory.createImageView(mode: .scaleAspectFit, image: UIImage(named: "Arrow-Bottom"))
    
    init(navigationController: UINavigationController?, title: String = "" , direction:Direction = .down) {
        self.buttonTitle = title
        self.direction = direction
        
        super.init(frame:navigationController?.navigationBar.bounds ?? .zero)
        
        defer {self.buttonTitle = title
               self.direction = direction }
        
        setupViews()
        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        sendActions(for: .touchUpInside)
    }
    
}
private extension NavigationButton {
    func setupViews() {
        self.addSubview(titleStack)
        
        titleStack
         .alignAllEdgesWithSuperview()
    }
}

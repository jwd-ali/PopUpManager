//
//  UIImageViewFactory.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 20/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
public class UIImageViewFactory {

    public class func createImageView(mode: UIImageView.ContentMode = .scaleAspectFill, image: UIImage? = nil, tintColor: UIColor? = .clear) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = mode
        imageView.tintColor = tintColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        return imageView
    }
}

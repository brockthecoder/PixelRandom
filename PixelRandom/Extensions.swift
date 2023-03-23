//
//  Extensions.swift
//  PixelRandom
//
//  Created by brock davis on 3/22/23.
//

import UIKit

extension CGColor {
    
    static var random: CGColor {
        return CGColor(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 1)
    }
}

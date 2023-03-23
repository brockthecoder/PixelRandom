//
//  PixelRandomView.swift
//  PixelRandom
//
//  Created by brock davis on 3/22/23.
//

import UIKit

class PixelRandomView: UIView {
    
    enum PixelMode {
        case rgb
        case random
    }
    
    let resolutionLabel = UILabel()
    
    var mode: PixelMode = .random {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    var pixelDimension: CGFloat = 1.0 / UIScreen.main.scale {
        didSet {
            self.setNeedsDisplay()
        }
    }


    override func draw(_ rect: CGRect) {
        
        let pixelSize = CGSize(width: self.pixelDimension, height: self.pixelDimension)
        
        let context = UIGraphicsGetCurrentContext()!
        
        let colors = [UIColor.red.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]
        
        var colorIndex = 0
        
        // Column
        for pixelX in stride(from: 0.0, through: self.bounds.maxX, by: pixelSize.width) {
            // Row
            for pixelY in stride(from: 0.0, through: self.bounds.maxY, by: pixelSize.height) {
                context.setFillColor(mode == .random ? .random : colors[colorIndex])
                context.addRect(CGRect(x: pixelX, y: pixelY, width: pixelSize.width, height: pixelSize.height))
                context.fillPath()
                colorIndex = (colorIndex + 1) % 3
            }
            colorIndex = (colorIndex + 1) % 3
        }
    }

}

//
//  DrowingView.swift
//  PointOfImage
//
//  Created by Rusłan Chamski on 13/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit



class DrawView: UIView {

    var imageV: UIImageView = {
        let iv = UIImageView(image:  UIImage(named: "logo"))
        iv.contentMode = .topLeft
        return iv
    }()

    var shape = CAShapeLayer()

    var color: UIColor?
    var loc: CGPoint?
    var line = [CGPoint]()
    var lines = [[CGPoint]]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageV)
        imageV.frame = frame
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func drawing() {

        if color == nil {
            color = imageV.image?.getPixelColor(pos: loc!)
        }

        let oldY = loc?.y
        var topY = [CGPoint]()
        var bottomY = [CGPoint]()
        while color == imageV.image?.getPixelColor(pos: loc!) {
            loc?.x += 1
        }
        loc?.x -= 1
        while color == imageV.image?.getPixelColor(pos: loc!) {
            loc?.x -= 1
            while color == imageV.image?.getPixelColor(pos: loc!) {
                loc?.y -= 1
            }
            topY.append(loc!)
            loc?.y = oldY!
        }
        loc?.x += 1
        while color == imageV.image?.getPixelColor(pos: loc!) {
            loc?.x += 1
            while color == imageV.image?.getPixelColor(pos: loc!) {
                loc?.y += 1
            }
            bottomY.append(loc!)
            loc?.y = oldY!
        }
        line = topY + bottomY
        color = nil
    }

    func shapeDrawing() {
        layer.addSublayer(shape)
        let context = UIBezierPath()

        for (i, p) in line.enumerated() {
            if i == 0 {
                context.move(to: p)
            } else {
                context.addLine(to: p)
            }
        }
        shape.path = context.cgPath
        shape.fillColor = UIColor.red.cgColor
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        loc = point
        drawing()
        shapeDrawing()
    }
}

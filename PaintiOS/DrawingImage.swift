//
//  DrawingImage.swift
//  PaintiOS
//
//  Created by Omar Aldair Romero Pérez on 1/26/19.
//  Copyright © 2019 Omar Aldair Romero Pérez. All rights reserved.
//

import UIKit

class DrawingImage: UIImageView {
    
    
    var currentPoint : CGPoint?
    public var currentColor: UIColor?
    public var currentLineWith: CGFloat?

    // Draw in ImageView with UIgraphicsImageRenderer
    func draw(from: CGPoint, to: CGPoint){
        
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        
        self.image = renderer.image(actions: { (context) in
            self.image?.draw(in: self.bounds)
            
            let color = self.currentColor ?? UIColor.white
            color.setStroke()
            context.cgContext.setLineCap(.round)
            let lineWith = self.currentLineWith ?? 5
            context.cgContext.setLineWidth(lineWith)
            
            context.cgContext.move(to: from)
            context.cgContext.addLine(to: to)
            context.cgContext.strokePath()
        })
    }
    
    
    func deleteMyDraw(){
        self.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.currentPoint = touches.first?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let newPoint = touches.first?.location(in: self) else { return }
        guard let previousPoint = self.currentPoint else { return }
        draw(from: previousPoint, to: newPoint)
        self.currentPoint = newPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.currentPoint = nil
    }
    
   

}

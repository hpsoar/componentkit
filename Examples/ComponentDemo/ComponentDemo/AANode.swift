//
//  AANode.swift
//  ComponentDemo
//
//  Created by HuangPeng on 7/6/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

import UIKit

class AAUINode {
    var hidden = false
    var position = CGPointZero
    var size = CGSizeZero
    var minSize = CGSizeZero
    var maxSize = CGSizeZero
    var frame = CGRectZero
    //var isParentOfChild = false
    
    func setup(view: UIView) {
        view.frame = frame
        view.hidden = hidden
    }
    
    func layoutIfNeeded() -> Void {
        calculateSizeIfNeeded()
        frame = CGRectMake(position.x, position.y, size.width, size.height)
        calculateFrameIfNeeded(frame)
    }
    
    func calculateSizeIfNeeded() -> Void {
        
    }
    
    func calculateFrameIfNeeded(frame: CGRect) -> Void {
        
    }
}

/// MARK - stack node

enum AAStackNodeAlignment {
    case Start
    case Center
    case End
}

enum AAStackNodeDirection {
    case Horizontal
    case Vertical
}

enum AAStackNodeChildAlignment {
    case Auto
    case Start
    case Center
    case End
    case Stretch
}

class AAStackNodeChild {
    var node: AAUINode!
    var spacingBefore: CGFloat =  0.0
    var spacingAfter: CGFloat =  0.0
    var flexGrow = false
    var flexShrink = false
    var alignSelf: AAStackNodeChildAlignment = .Auto
    
    func node(node: AAUINode) -> Self {
        self.node = node
        return self
    }
    
    func spacingBefore(spacingBefore: CGFloat) -> Self {
        self.spacingBefore = spacingBefore
        return self
    }
    
    func spacingAfter(spacingAfter: CGFloat) -> Self {
        self.spacingAfter = spacingAfter
        return self
    }
    
    func alignSelf(alignSelf: AAStackNodeChildAlignment) -> Self {
        self.alignSelf = alignSelf
        return self
    }
    
    func flexGrow(flexGrow: Bool) -> Self {
        self.flexGrow = flexGrow
        return self
    }
    
    func flexShrink(flexShrink: Bool) -> Self {
        self.flexShrink = flexShrink
        return self
    }
    
    func stackDim(direction: AAStackNodeDirection) -> CGFloat {
        return direction == .Horizontal ? node.size.height : node.size.width
    }
    
    func crossDim(direction: AAStackNodeDirection) -> CGFloat {
        return direction == .Horizontal ? node.size.width : node.size.height
    }
    
    func stackSpan(direction: AAStackNodeDirection) -> CGFloat {
        return stackDim(direction) + spacingAfter + spacingBefore
    }
    func crossSpan(direction: AAStackNodeDirection) -> CGFloat {
        return crossDim(direction)
    }
    
    func updateCrossDim(dim: CGFloat, direction: AAStackNodeDirection) {
        if direction == .Horizontal {
            node.size.height = dim
        }
        else {
            node.size.width = dim
        }
    }
    
    func updateStackPosition(position: CGFloat, direction: AAStackNodeDirection) {
        if (direction == .Horizontal) {
            node.position.x = position
        }
        else {
            node.position.y = position
        }
    }
    
    func updateCrossPosition(position: CGFloat, direction: AAStackNodeDirection) {
        if (direction == .Horizontal) {
            node.position.y = position
        }
        else {
            node.position.x = position
        }
    }
}

class AAStackNode: AAUINode {
    var direction: AAStackNodeDirection = .Horizontal
    var spacing: CGFloat = 0.0
    var alignItems: AAStackNodeAlignment = .End
    
    var children = [AAStackNodeChild]()
    
    func direction(direction: AAStackNodeDirection) -> Self {
        self.direction = direction
        return self
    }
    
    func spacing(spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }
    
    func alignItems(alignItems: AAStackNodeAlignment) -> Self {
        self.alignItems = alignItems
        return self
    }
    
    func children(children: [AAStackNodeChild]) -> Self {
        self.children = children
        return self
    }
    
    func child(child: AAStackNodeChild) -> Self {
        self.children.append(child)
        return self
    }
    
    override func calculateSizeIfNeeded() {
        for child in children {
            child.node.calculateSizeIfNeeded()
        }
        
        if direction == .Horizontal {
            self.size.width = stackDimension()
            self.size.height = crossDimension()
        }
        else {
            self.size.height = stackDimension()
            self.size.width = crossDimension()
        }
    }
    
    override func calculateFrameIfNeeded(frame: CGRect) {
        self.frame = frame
        
        let position = self.frame.origin
        var space = CGFloat(0)
        var stackPosition = direction == .Horizontal ? position.x : position.y
        let crossStart = direction == .Horizontal ? position.y : position.x
        for child in children {
            stackPosition += space + child.spacingBefore
            child.updateStackPosition(stackPosition, direction: direction)
            stackPosition += child.spacingAfter
            
            let crossPosition = crossPositionforChild(child) + crossStart
            child.updateCrossDim(crossPosition, direction: direction)
            
            space = spacing
        }
    }
    
    func crossDimension(direction: AAStackNodeDirection) -> CGFloat {
        return direction == .Horizontal ? size.height : size.width
    }
    
    func crossPositionforChild(child: AAStackNodeChild) -> CGFloat {
        switch child.alignSelf {
        case .Auto:
            return crossPositionForChild(child, alignment: alignItems)
        case .Start:
            return crossPositionForChild(child, alignment: .Start)
        case .Center:
            return crossPositionForChild(child, alignment: .Center)
        case .End:
            return crossPositionForChild(child, alignment: .End)
        case .Stretch:
            child.updateCrossDim(crossDimension(), direction: direction)
            return crossPositionForChild(child, alignment: .Start)
        }
    }
    
    func crossPositionForChild(child: AAStackNodeChild, alignment: AAStackNodeAlignment) -> CGFloat {
        switch alignment {
        case .Start:
            return CGFloat(0)
        case .Center:
            return (crossDimension() - child.crossDim(direction)) / 2.0
        case .End:
            return crossDimension() - child.crossDim(direction)
        }
    }
    
    func stackDimension() -> CGFloat {
        var dim = CGFloat(0)
        var space = CGFloat(0)
        for child in children {
            dim += space + child.stackDim(direction)
            space = spacing
        }
        return dim
    }
    
    func crossDimension() -> CGFloat {
        var dim = CGFloat(0)
        for child in children {
            dim = max(dim, child.crossDim(direction))
        }
        return dim
    }
}

/// MARK - inset node

class AAInsetNode: AAUINode {
    var child : AAUINode?
    var insets = UIEdgeInsetsZero        
    
    func insets(insets: UIEdgeInsets) -> Self {
        self.insets = insets
        return self
    }
    
    func child(child: AAUINode) -> Self {
        self.child = child
        return self
    }
    
    override func calculateSizeIfNeeded() {
        child!.calculateSizeIfNeeded()
        size.width = child!.size.width + insets.left + insets.right
        size.height = child!.size.height + insets.top + insets.bottom
    }
    
    override func calculateFrameIfNeeded(frame: CGRect) {
        self.frame = frame
        
        var f = frame
        f.origin.x += insets.left
        f.origin.y += insets.top
        child!.calculateFrameIfNeeded(f)
    }
}

/// MARK - label node

class AALabelNode: AAUINode {
    var text: NSString = ""
    var attributedText: NSAttributedString? = nil
    
    override func layoutIfNeeded() {
        // do layout: compute size
    }
    
    override func calculateSizeIfNeeded() {
        if attributedText != nil {
            size = attributedText!.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil).size
        }
        else {
            let attributes = [ NSFontAttributeName: UIFont.systemFontOfSize(16) ]
            size = text.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil).size
        }
    }
    
    override func calculateFrameIfNeeded(frame: CGRect) {
        self.frame = frame
    }
}


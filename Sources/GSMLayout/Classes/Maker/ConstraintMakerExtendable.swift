//
//  ConstraintMakerExtendable.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/18.
//

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public class ConstraintMakerExtendable{
    public var left: ConstraintMakerExtendable {
        return self
    }
    
    public var top: ConstraintMakerExtendable {
        return self
    }
    
    public var bottom: ConstraintMakerExtendable {
        return self
    }
    
    public var right: ConstraintMakerExtendable {
        return self
    }
    
    public var leading: ConstraintMakerExtendable {
        return self
    }
    
    public var trailing: ConstraintMakerExtendable {
        return self
    }
    
    public var width: ConstraintMakerExtendable {
        return self
    }
    
    public var height: ConstraintMakerExtendable {
        return self
    }
    
    public var centerX: ConstraintMakerExtendable {
        return self
    }
    
    public var centerY: ConstraintMakerExtendable {
        return self
    }
    
    @available(*, deprecated, renamed:"lastBaseline")
    public var baseline: ConstraintMakerExtendable {
        return self
    }
    
    public var lastBaseline: ConstraintMakerExtendable {
        return self
    }
    
    @available(iOS 8.0, OSX 10.11, *)
    public var firstBaseline: ConstraintMakerExtendable {
        return self
    }
    
    @available(iOS 8.0, *)
    public var leftMargin: ConstraintMakerExtendable {
        return self
    }
    
    @available(iOS 8.0, *)
    public var rightMargin: ConstraintMakerExtendable {
        return self
    }
    
    @available(iOS 8.0, *)
    public var topMargin: ConstraintMakerExtendable {
        return self
    }
    
    @available(iOS 8.0, *)
    public var bottomMargin: ConstraintMakerExtendable {
        return self
    }
    
    @available(iOS 8.0, *)
    public var leadingMargin: ConstraintMakerExtendable {
        return self
    }
    
    @available(iOS 8.0, *)
    public var trailingMargin: ConstraintMakerExtendable {
        return self
    }
    
    @available(iOS 8.0, *)
    public var centerXWithinMargins: ConstraintMakerExtendable {
        return self
    }
    
    @available(iOS 8.0, *)
    public var centerYWithinMargins: ConstraintMakerExtendable {
        return self
    }
    
    public var edges: ConstraintMakerExtendable {
        return self
    }
    public var horizontalEdges: ConstraintMakerExtendable {
        return self
    }
    public var verticalEdges: ConstraintMakerExtendable {
        return self
    }
    public var directionalEdges: ConstraintMakerExtendable {
        return self
    }
    public var directionalHorizontalEdges: ConstraintMakerExtendable {
        return self
    }
    public var directionalVerticalEdges: ConstraintMakerExtendable {
        return self
    }
    public var size: ConstraintMakerExtendable {
        return self
    }
    
    @available(iOS 8.0, *)
    public var margins: ConstraintMakerExtendable {
        return self
    }
    
    @available(iOS 8.0, *)
    public var directionalMargins: ConstraintMakerExtendable {
      return self
    }

    @available(iOS 8.0, *)
    public var centerWithinMargins: ConstraintMakerExtendable {
        return self
    }
    
}

//
//  GSMLayout+CoordinatorMakerExtendable.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/27.
//

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public class GSMLayoutConstraintMakerExtendable : GSMLayoutConstraintMakerRelatable{
    
    public var left: GSMLayoutConstraintMakerExtendable {
        self.description = "left"
        return self
    }
    
    public var top: GSMLayoutConstraintMakerExtendable {
        self.description = "top"
        return self
    }
    
    public var bottom: GSMLayoutConstraintMakerExtendable {
        self.description = "bottom"
        return self
    }
    
    public var right: GSMLayoutConstraintMakerExtendable {
        self.description = "right"
        return self
    }
    
    public var leading: GSMLayoutConstraintMakerExtendable {
        self.description = "leading"
        return self
    }
    
    public var trailing: GSMLayoutConstraintMakerExtendable {
        self.description = "trailing"
        return self
    }
    
    public var width: GSMLayoutConstraintMakerExtendable {
        self.description = "width"
        return self
    }
    
    public var height: GSMLayoutConstraintMakerExtendable {
        self.description = "height"
        return self
    }
    
    public var centerX: GSMLayoutConstraintMakerExtendable {
        self.description = "centerX"
        return self
    }
    
    public var centerY: GSMLayoutConstraintMakerExtendable {
        self.description = "centerY"
        return self
    }

}

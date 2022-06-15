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
        self.description.append("left")
        return self
    }
    
    public var top: GSMLayoutConstraintMakerExtendable {
        self.description.append("top")
        return self
    }
    
    public var bottom: GSMLayoutConstraintMakerExtendable {
        self.description.append("bottom")
        return self
    }
    
    public var right: GSMLayoutConstraintMakerExtendable {
        self.description.append("right")
        return self
    }
    
    public var leading: GSMLayoutConstraintMakerExtendable {
        self.description.append("leading")
        return self
    }
    
    public var trailing: GSMLayoutConstraintMakerExtendable {
        self.description.append("trailing")
        return self
    }
    
    public var width: GSMLayoutConstraintMakerExtendable {
        self.description.append("width")
        return self
    }
    
    public var height: GSMLayoutConstraintMakerExtendable {
        self.description.append("height")
        return self
    }
    
    public var centerX: GSMLayoutConstraintMakerExtendable {
        self.description.append("centerX")
        return self
    }
    
    public var centerY: GSMLayoutConstraintMakerExtendable {
        self.description.append( "centerY")
        return self
    }

}

//
//  ConstraintMaker.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/17.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public class ConstraintMaker {
    public var left : ConstraintMakerExtendable{
        return self.makeExtendableWithAttributes(.left)
    }
    public var top : ConstraintMakerExtendable{
        return self.makeExtendableWithAttributes(.top)
    }
    public var bottom : ConstraintMakerExtendable{
        return self.makeExtendableWithAttributes(.bottom)
    }
    public var right : ConstraintMakerExtendable{
        return self.makeExtendableWithAttributes(.right)
 
    }
    public var leading: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.leading)
    }
    
    public var trailing: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.trailing)
    }
    
    public var width: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.width)
    }
    
    public var height: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.height)
    }
    
    public var centerX: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerX)
    }
    
    public var centerY: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerY)
    }
    
    internal func makeExtendableWithAttributes(_ attributes: ConstraintAttributes) -> ConstraintMakerExtendable {
        print(attributes.rawValue)
        return ConstraintMakerExtendable()
    }
}

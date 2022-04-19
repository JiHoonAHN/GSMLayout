//
//  Layoutable+GSMLayout.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

import Foundation

extension Layoutable{
    public var anchor : AnchorList{
        return AnchorListImpl(view: self as! View)
    }
    
    public var edge: EdgeList{
        return EdgeListImpl(view: self as! View)
    }

}

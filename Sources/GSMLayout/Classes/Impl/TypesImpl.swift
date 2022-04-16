//
//  TypesImpl.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

import Foundation

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

typealias Context = () -> String

struct Size{
    var width : CGFloat?
    var height : CGFloat?
}

class EdgeListImpl<View : Layoutable> {
    let view : View
    
    init(view : View){
        self.view = view
    }
    

}

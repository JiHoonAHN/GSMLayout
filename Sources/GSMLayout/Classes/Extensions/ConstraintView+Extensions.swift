//
//  ConstraintView+Extensions.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/21.
//

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif


public extension ConstraintView {
    
    @available(*, deprecated, renamed:"gsm.left")
    var gsm_left: ConstraintItem { return self.gsm.left }
    
    @available(*, deprecated, renamed:"gsm.top")
    var gsm_top: ConstraintItem { return self.gsm.top }
    
    @available(*, deprecated, renamed:"gsm.right")
    var gsm_right: ConstraintItem { return self.gsm.right }
    
    @available(*, deprecated, renamed:"gsm.bottom")
    var gsm_bottom: ConstraintItem { return self.gsm.bottom }
    
    @available(*, deprecated, renamed:"gsm.leading")
    var gsm_leading: ConstraintItem { return self.gsm.leading }
    
    @available(*, deprecated, renamed:"gsm.trailing")
    var gsm_trailing: ConstraintItem { return self.gsm.trailing }
    
    @available(*, deprecated, renamed:"gsm.width")
    var gsm_width: ConstraintItem { return self.gsm.width }
    
    @available(*, deprecated, renamed:"gsm.height")
    var gsm_height: ConstraintItem { return self.gsm.height }
    
    @available(*, deprecated, renamed:"gsm.centerX")
    var gsm_centerX: ConstraintItem { return self.gsm.centerX }
    
    @available(*, deprecated, renamed:"gsm.centerY")
    var gsm_centerY: ConstraintItem { return self.gsm.centerY }
    
    @available(*, deprecated, renamed:"gsm.baseline")
    var gsm_baseline: ConstraintItem { return self.gsm.baseline }
    
    @available(*, deprecated, renamed:"gsm.lastBaseline")
    @available(iOS 8.0, OSX 10.11, *)
    var gsm_lastBaseline: ConstraintItem { return self.gsm.lastBaseline }
    
    @available(iOS, deprecated, renamed:"gsm.firstBaseline")
    @available(iOS 8.0, OSX 10.11, *)
    var gsm_firstBaseline: ConstraintItem { return self.gsm.firstBaseline }
    
    @available(iOS, deprecated, renamed:"gsm.leftMargin")
    @available(iOS 8.0, *)
    var gsm_leftMargin: ConstraintItem { return self.gsm.leftMargin }
    
    @available(iOS, deprecated, renamed:"gsm.topMargin")
    @available(iOS 8.0, *)
    var gsm_topMargin: ConstraintItem { return self.gsm.topMargin }
    
    @available(iOS, deprecated, renamed:"gsm.rightMargin")
    @available(iOS 8.0, *)
    var gsm_rightMargin: ConstraintItem { return self.gsm.rightMargin }
    
    @available(iOS, deprecated, renamed:"gsm.bottomMargin")
    @available(iOS 8.0, *)
    var gsm_bottomMargin: ConstraintItem { return self.gsm.bottomMargin }
    
    @available(iOS, deprecated, renamed:"gsm.leadingMargin")
    @available(iOS 8.0, *)
    var gsm_leadingMargin: ConstraintItem { return self.gsm.leadingMargin }
    
    @available(iOS, deprecated, renamed:"gsm.trailingMargin")
    @available(iOS 8.0, *)
    var gsm_trailingMargin: ConstraintItem { return self.gsm.trailingMargin }
    
    @available(iOS, deprecated, renamed:"gsm.centerXWithinMargins")
    @available(iOS 8.0, *)
    var gsm_centerXWithinMargins: ConstraintItem { return self.gsm.centerXWithinMargins }
    
    @available(iOS, deprecated, renamed:"gsm.centerYWithinMargins")
    @available(iOS 8.0, *)
    var gsm_centerYWithinMargins: ConstraintItem { return self.gsm.centerYWithinMargins }
    
    @available(*, deprecated, renamed:"gsm.edges")
    var gsm_edges: ConstraintItem { return self.gsm.edges }
    
    @available(*, deprecated, renamed:"gsm.size")
    var gsm_size: ConstraintItem { return self.gsm.size }
    
    @available(*, deprecated, renamed:"gsm.center")
    var gsm_center: ConstraintItem { return self.gsm.center }
    
    @available(iOS, deprecated, renamed:"gsm.margins")
    @available(iOS 8.0, *)
    var gsm_margins: ConstraintItem { return self.gsm.margins }
    
    @available(iOS, deprecated, renamed:"gsm.centerWithinMargins")
    @available(iOS 8.0, *)
    var gsm_centerWithinMargins: ConstraintItem { return self.gsm.centerWithinMargins }
    
    @available(*, deprecated, renamed:"gsm.prepareConstraints(_:)")
    func gsm_prepareConstraints(_ closure: (_ make: ConstraintMaker) -> Void) -> [Constraint] {
        return self.gsm.prepareConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"gsm.makeConstraints(_:)")
    func gsm_makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.gsm.makeConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"gsm.remakeConstraints(_:)")
    func gsm_remakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.gsm.remakeConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"gsm.updateConstraints(_:)")
    func gsm_updateConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.gsm.updateConstraints(closure)
    }
    
    @available(*, deprecated, renamed:"gsm.removeConstraints()")
    func gsm_removeConstraints() {
        self.gsm.removeConstraints()
    }
    
    var gsm: ConstraintViewDSL {
        return ConstraintViewDSL(view: self)
    }
    
}

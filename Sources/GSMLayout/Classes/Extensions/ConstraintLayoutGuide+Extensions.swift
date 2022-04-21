#if os(iOS) || os(tvOS)
    import UIKit
#endif
    
    
@available(iOS 9.0, OSX 10.11, *)
public extension ConstraintLayoutGuide {
    
    var gsm: ConstraintLayoutGuideDSL {
        return ConstraintLayoutGuideDSL(guide: self)
    }
    
}

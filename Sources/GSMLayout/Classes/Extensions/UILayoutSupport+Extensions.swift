#if os(iOS) || os(tvOS)
    import UIKit
#endif

    
@available(iOS 8.0, *)
public extension ConstraintLayoutSupport {
    
    var gsm: ConstraintLayoutSupportDSL {
        return ConstraintLayoutSupportDSL(support: self)
    }
    
}

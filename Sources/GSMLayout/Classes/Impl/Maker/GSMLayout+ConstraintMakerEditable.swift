#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public class GSMLayoutConstraintMakerFinalizable  {
    let description : String
    
    init(_ description : String){
        self.description = description
    }
}

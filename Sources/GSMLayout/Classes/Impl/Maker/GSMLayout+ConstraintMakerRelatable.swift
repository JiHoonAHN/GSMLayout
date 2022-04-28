#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public class GSMLayoutConstraintMakerRelatable {
    
    internal var description: String
    
    internal init(_ description: String) {
        self.description = description
    }
    
    func relatedTo(file: String, line: UInt) -> GSMLayoutConstraintMakerEditable{
        return GSMLayoutConstraintMakerEditable()
    }
    
    @discardableResult
    public func equalTo( _ file: String = #file, _ line: UInt = #line) -> GSMLayoutConstraintMakerEditable {
        print("Realod")
        return self.relatedTo(file: file, line: line)
    }
}


#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public class GSMLayoutConstraintMakerRelatable {
    
    internal var description: [String]
    
    internal init(_ description: [String]) {
        self.description = description
    }
    
    func relatedTo(file: String, line: UInt) -> GSMLayoutConstraintMakerFinalizable{
        
        let editable = GSMLayoutConstraintMakerFinalizable(self.description)
        print("Relatable : \(description)")
        
        return GSMLayoutConstraintMakerFinalizable(description)
    }
    
    @discardableResult
    public func equalTo( _ file: String = #file, _ line: UInt = #line) -> GSMLayoutConstraintMakerFinalizable {
        return self.relatedTo(file: file, line: line)
    }
}

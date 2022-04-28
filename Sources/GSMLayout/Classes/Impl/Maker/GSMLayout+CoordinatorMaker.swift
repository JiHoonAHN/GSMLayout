#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public class  GSMLayoutConstraintMaker<View : Layoutable>{
    let view : View
    
    public var left : GSMLayoutConstraintMakerExtendable{
        return self.makeExtendableWithAttributes("left")
    }
    public var top: GSMLayoutConstraintMakerExtendable {
        return self.makeExtendableWithAttributes("top")
    }
    
    public var bottom: GSMLayoutConstraintMakerExtendable {
        return self.makeExtendableWithAttributes("bottom")
    }
    
    public var right: GSMLayoutConstraintMakerExtendable {
        return self.makeExtendableWithAttributes("right")
    }
    
    public var leading: GSMLayoutConstraintMakerExtendable {
        return self.makeExtendableWithAttributes("leading")
    }
    
    public var trailing: GSMLayoutConstraintMakerExtendable {
        return self.makeExtendableWithAttributes("trailing")
    }
    
    public var width: GSMLayoutConstraintMakerExtendable {
        return self.makeExtendableWithAttributes("width")
    }
    
    public var height: GSMLayoutConstraintMakerExtendable {
        return self.makeExtendableWithAttributes("height")
    }
    
    public var centerX: GSMLayoutConstraintMakerExtendable {
        return self.makeExtendableWithAttributes("centerX")
    }
    
    public var centerY: GSMLayoutConstraintMakerExtendable {
        return self.makeExtendableWithAttributes("centerY")
    }
    
    private var descriptions = [String]()
    
    internal func prepareConstraints( closure: (GSMLayoutConstraintMaker) -> Void) -> [String] {
        var constraints: [String] = []
        for description in descriptions {
            constraints.append(description)
        }
        return constraints
    }
    
    func makeExtendableWithAttributes(_ attributes : String) -> GSMLayoutConstraintMakerExtendable{
        self.descriptions.append(attributes)
        return GSMLayoutConstraintMakerExtendable(attributes)
    }
    
    internal init(view : View, closure : ((GSMLayoutConstraintMaker) -> Void)) {
        self.view = view
        descriptions = prepareConstraints(closure: closure)
        print(descriptions.first) // -> nil
    }
}

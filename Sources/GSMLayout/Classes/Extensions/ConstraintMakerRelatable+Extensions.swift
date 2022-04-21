#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif


extension ConstraintMakerRelatable {
  
    @discardableResult
    public func equalToSuperview<T: ConstraintRelatableTarget>(_ closure: (ConstraintView) -> T, _ file: String = #file, line: UInt = #line) -> ConstraintMakerEditable {
        guard let other = self.description.item.superview else {
            fatalError("Expected superview but found nil when attempting make constraint `equalToSuperview`.")
        }
        return self.relatedTo(closure(other), relation: .equal, file: file, line: line)
    }
  
    @discardableResult
    public func lessThanOrEqualToSuperview<T: ConstraintRelatableTarget>(_ closure: (ConstraintView) -> T, _ file: String = #file, line: UInt = #line) -> ConstraintMakerEditable {
        guard let other = self.description.item.superview else {
            fatalError("Expected superview but found nil when attempting make constraint `lessThanOrEqualToSuperview`.")
        }
        return self.relatedTo(closure(other), relation: .lessThanOrEqual, file: file, line: line)
    }
  
    @discardableResult
    public func greaterThanOrEqualTo<T: ConstraintRelatableTarget>(_ closure: (ConstraintView) -> T, _ file: String = #file, line: UInt = #line) -> ConstraintMakerEditable {
        guard let other = self.description.item.superview else {
            fatalError("Expected superview but found nil when attempting make constraint `greaterThanOrEqualToSuperview`.")
        }
        return self.relatedTo(closure(other), relation: .greaterThanOrEqual, file: file, line: line)
    }
  
}

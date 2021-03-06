//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

/// A view description.
///
/// The description is composed of two things - the view's name and the view's frame.
public struct _NamedViewDescription: Equatable {
    @usableFromInline
    let name: ViewName
    @usableFromInline
    let bounds: Anchor<CGRect>
    @usableFromInline
    let globalBounds: CGRect
    
    @usableFromInline
    init(
        name: ViewName,
        bounds: Anchor<CGRect>,
        globalBounds: CGRect
    ) {
        self.name = name
        self.bounds = bounds
        self.globalBounds = globalBounds
    }
    
    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        guard lhs.name == rhs.name else {
            return false
        }
        
        guard lhs.globalBounds == rhs.globalBounds else {
            return false
        }
        
        return true
    }
}

extension _NamedViewDescription {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        typealias Value = [ViewName: _NamedViewDescription]
        
        static var defaultValue: Value {
            [:]
        }
        
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value.merge(nextValue(), uniquingKeysWith: { lhs, rhs in lhs })
        }
    }
}

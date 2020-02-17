//
//  Transition.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

public struct Transition<RootViewController: UIViewController>: TransitionProtocol {

    public typealias PerformClosure = ( _ rootViewController: RootViewController,
                                        _ options: TransitionOptions,
                                        _ completion: NavigationHandler?) -> Void

    //MARK: - Lifecycle

    public init(presentables: [Presentable], animation: Animation? = nil, performClosure: @escaping PerformClosure) {
        self.presentables = presentables
        self.animation = animation
        self.performClosure = performClosure
    }

    //MARK: - Private

    private var presentables: [Presentable]
    private var animation: Animation?
    private var performClosure: PerformClosure

    public func perform(on rootViewController: RootViewController, options: TransitionOptions = .default, completion: NavigationHandler? = nil) {
        self.performClosure(rootViewController, options, completion)
    }

    public func perform(for rootViewController: RootViewController, with options: TransitionOptions, completion: NavigationHandler?) {
        autoreleasepool {
            self.performClosure(rootViewController, options, completion)
        }
    }

    // MARK: - Static

    public static func none() -> Transition {
        return Transition(presentables: []) { (_, _, completion) in
            completion?()
        }
     }
}

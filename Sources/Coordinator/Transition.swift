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
                                        _ animation: Animation?,
                                        _ completion: NavigationHandler?) -> Void

    //MARK: - Lifecycle

    init(presentables: [Presentable], animation: Animation? = nil, performClosure: @escaping PerformClosure) {
        self.presentables = presentables
        self.animation = animation
        self.performClosure = performClosure
    }

    //MARK: - Private

    private var presentables: [Presentable]
    private var animation: Animation?
    private var performClosure: PerformClosure

    public func perform(on rootViewController: RootViewController, animated: Bool) {
        self.performClosure(rootViewController, nil, nil)
    }

    public func perform(for rootViewController: RootViewController, with options: Any?, completion: NavigationHandler?) {
        #warning("autorelease pool")
        self.performClosure(rootViewController, nil, completion)
    }
}

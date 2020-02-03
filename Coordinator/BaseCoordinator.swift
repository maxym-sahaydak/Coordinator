//
//  BaseCoordinator.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

open class BaseCoordinator<StepType: Step, RooViewController: UIViewController>: Coordinator {
    public var viewConroller: UIViewController!


    //MARK: - Initialization

    public init(rootViewController: RooViewController) {
        self.rootViewController = rootViewController
    }

    //MARK: - Public

    public private(set) var rootViewController: RooViewController

    public func navigate(to step: Step) {
        fatalError("should be implemented in subclass")
    }

    public func transition(for step: Step) -> Transition<UIViewController> {
        fatalError("should be implemented in subclass")
    }

    //MARK: - Open

    open var viewController: UIViewController! {
        rootViewController
    }

}

//
//  NavigationCoordinator.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

open class NavigationCoordinator<StepType: Step>: BaseCoordinator<StepType, NavigationTransition> {

    public override init(rootViewController: UINavigationController = .init()) {
        if rootViewController.delegate == nil {
            rootViewController.delegate = animationDelegate
        }
        super.init(rootViewController: rootViewController)
    }

    public override init(rootViewController: UINavigationController, step: StepType) {
        if rootViewController.delegate == nil {
            rootViewController.delegate = animationDelegate
        }
        super.init(rootViewController: rootViewController, step: step)
    }


    public let animationDelegate = NavigationControllerAnimationDelegate()
    public var delegate: UINavigationControllerDelegate? {
        get {
            animationDelegate.delegate
        }
        set {
            animationDelegate.delegate = newValue
        }
    }

    //MAKR: -

        public override func navigate(to step: StepType) {
            let transition = self.transition(for: step)
            transition.perform(on: rootViewController)
        }
}



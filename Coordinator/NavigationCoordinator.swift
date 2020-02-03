//
//  NavigationCoordinator.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

open class NavigationCoordinator<StepType: Step>: BaseCoordinator<StepType, UINavigationController> {//BaseCoordinator<StepType, RooViewController: UINavigationController> {

    public override init(rootViewController: UINavigationController) {
        if rootViewController.delegate == nil {
            rootViewController.delegate = animationDelegate
        }
        super.init(rootViewController: rootViewController)
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
}

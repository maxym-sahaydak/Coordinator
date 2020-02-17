//
//  UINavigationController+Transition.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

public typealias NavigationTransition = Transition<UINavigationController>

extension Transition where RootViewController: UINavigationController {

     public static func push(_ presentable: Presentable, animation: Animation? = nil) -> Self {
        return Transition(presentables: [presentable], animation: animation?.presentAnimation) { (rootViewController, options, completion) in
            rootViewController.push(presentable.viewConroller, animation: animation) {
                #warning("add presented notification")
                completion?()
            }

        }
    }

    public static func pop(animation: Animation? = nil) -> Self {
        return Transition(presentables: [], animation: animation?.dissmissAnimation) { (rootViewController, animation, completion) in
            rootViewController.popViewController(animated: true)
        }
    }

    public static func pop(to presentable: Presentable, animation: Animation? = nil) -> Self {
        return Transition(presentables: [presentable], animation: animation?.dissmissAnimation) { (rootViewController, animation, completion) in
            rootViewController.popToViewController(presentable.viewConroller, animated: true)
        }
    }

    public static func popToRoot(animation: Animation? = nil) -> Self {
        return Transition(presentables: [], animation: animation?.dissmissAnimation) { (rootViewController, animation, completion) in
            rootViewController.popToRootViewController(animated: true)
        }
    }

    public static func set(_ presentables: [Presentable], animation: Animation? = nil) -> Self {
        return Transition(presentables: presentables, animation: animation?.dissmissAnimation) { (rootViewController, animation, completion) in
            rootViewController.setViewControllers(presentables.map{ $0.viewConroller }, animated: true)
        }
    }
}

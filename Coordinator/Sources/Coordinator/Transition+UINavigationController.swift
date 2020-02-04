//
//  UINavigationController+Transition.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

extension Transition where RootViewController: UINavigationController {

    public static func push(_ presentable: Presentable, animation: Animation? = nil) -> Self {
        return Transition(presentables: [presentable], animation: animation) { (rootViewController, animation, completion) in
            rootViewController.pushViewController(presentable.viewConroller, animated: true)
        }
    }

    public static func pop(animation: Animation? = nil) -> Self {
        return Transition(presentables: [], animation: animation) { (rootViewController, animation, completion) in
            rootViewController.popViewController(animated: true)
        }
    }

    public static func pop(to presentable: Presentable, animation: Animation? = nil) -> Self {
        return Transition(presentables: [presentable], animation: animation) { (rootViewController, animation, completion) in
            rootViewController.popToViewController(presentable.viewConroller, animated: true)
        }
    }

    public static func popToRoot(animation: Animation? = nil) -> Self {
        return Transition(presentables: [], animation: animation) { (rootViewController, animation, completion) in
            rootViewController.popToRootViewController(animated: true)
        }
    }

    public static func set(_ presentables: [Presentable], animation: Animation? = nil) -> Self {
        return Transition(presentables: presentables, animation: animation) { (rootViewController, animation, completion) in
            rootViewController.setViewControllers(presentables.map{ $0.viewConroller }, animated: true)
        }
    }
}

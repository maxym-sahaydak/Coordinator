//
//  File.swift
//  
//
//  Created by Maxym Sahaydak on 11.02.2020.
//

import Foundation
import UIKit

extension Transition {

    public static func show(_ presentable: Presentable) -> Self {
        return Transition(presentables: [presentable], animation: nil) { (rootViewController, animation, completion) in
            rootViewController.show(presentable.viewConroller, options: .default, completion: completion)
        }
    }

    public static func presentOverFullScreen(_ presentable: Presentable, animation: Animation? = nil) -> Self {
        return Transition(presentables: [presentable], animation: animation?.presentAnimation) { (rooViewController, options, completion) in
            presentable.viewConroller.modalPresentationStyle = .overFullScreen
            rooViewController.present(onRoot: true, presentable.viewConroller,
                                      animation: animation,
                                      options: options,
                                      completion: completion)
        }
    }
}

//extension Transition where RootViewController: UIViewController {
//
//    public static func show(_ viewController: UIViewController) -> Self {
//        return Transition(presentables: [viewController], animation: nil) { (rootViewController, nil, completion) in
//            rootViewController.show(viewController, sender: nil)
//            completion?()
//        }
//    }
//
//    public static func present(_ viewController: UIViewController, animation: Animation? = nil) -> Self {
//        return Transition(presentables: [viewController], animation: nil) { (rootViewController, animation, completion) in
//            rootViewController.present(viewController, animated: true, completion: completion)
//        }
//    }
//
//    public static func presentOverFullScreen(_ viewConroller: UIViewController, animation: Animation? = nil) -> Self {
//        return Transition(presentables: [viewConroller], animation: animation) { (rooViewController, animation, completion) in
//            viewConroller.modalPresentationStyle = .overFullScreen
//            rooViewController.present(viewConroller, animated: true, completion: completion)
//        }
//    }
//
//    public static func dismiss(_ animated: Bool = false, completion: NavigationHandler?) -> Self {
//        return Transition(presentables: [], animation: nil) { (rooViewController, nil, completion) in
//            rooViewController.viewConroller.dismiss(animated: animated, completion: completion)
//        }
//    }
//
//
//}

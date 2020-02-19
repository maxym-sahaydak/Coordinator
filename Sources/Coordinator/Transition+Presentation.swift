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
            rootViewController.show(presentable.viewConroller,
                                    options: .default,
                                    completion: completion)
        }
    }

    public static func presentOverFullScreen(_ presentable: Presentable, animation: Animation? = nil) -> Self {
        return Transition(presentables: [presentable], animation: animation?.presentAnimation) { (rootViewController, options, completion) in
            presentable.viewConroller.modalPresentationStyle = .overFullScreen
            rootViewController.present(onRoot: true, presentable.viewConroller,
                                      animation: animation,
                                      options: options,
                                      completion: completion)
        }
    }

    public static func present(_ presentable: Presentable, animation: Animation? = nil) -> Self {
        return Transition(presentables: [presentable], animation: animation?.presentAnimation) { (rootViewController, options, completion) in
            rootViewController.present(onRoot: true, presentable.viewConroller,
                                      animation: animation,
                                      options: options,
                                      completion: completion)
        }
    }

    public static func dismiss(animation: Animation? = nil) -> Self {
        return Transition(presentables: [], animation: animation?.dissmissAnimation) { (rootViewController, options, completion) in
            rootViewController.dismiss(toRoot: false,
                                       options: options,
                                       animation: animation,
                                       completion: completion)
        }
    }

    // TODO: - Add dissmiss
}



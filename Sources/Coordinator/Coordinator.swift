//
//  Coordinator.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 31.01.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

public typealias NavigationHandler = () -> Void

public protocol Coordinator: TransitionPerformer {

    associatedtype StepType = Step

    //MARK: - Public

    func navigate(to step: StepType)

}



//MARK: - Presentable

extension Coordinator {

    public var viewConroller: UIViewController! {
        fatalError("need to be inplemented in transition performer ...")
       return UIViewController.init()
    }
}

extension Coordinator where Self: AnyObject {

    public func performTransition(_ transition: TransitionType, options: TransitionOptions, completion: NavigationHandler? = nil) {
        transition.perform(on: rootViewController, options: options) {
            completion?()
        }
    }
}

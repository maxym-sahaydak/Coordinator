//
//  Coordinator.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 31.01.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

public protocol Coordinator: Presentable {

    associatedtype StepType = Step

    //MARK: - Public

    func navigate(to step: StepType)

    //MARRK: - Open

    func transition(for step: StepType) -> Transition<UIViewController>

}



//MARK: - Presentable

extension Coordinator {

    public var viewConroller: UIViewController! {
        fatalError("need to be inplemented in transition performer ...")
        UIViewController.init()
    }
}


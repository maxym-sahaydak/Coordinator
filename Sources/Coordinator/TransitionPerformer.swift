//
//  File.swift
//  
//
//  Created by Maxym Sahaydak on 17.02.2020.
//

import Foundation

public protocol TransitionPerformer: Presentable {

    associatedtype TransitionType: TransitionProtocol

    var rootViewController: TransitionType.RootViewController { get }

    func performTransition(_ transition: TransitionType,
                           options: TransitionOptions,
                           completion: NavigationHandler?)
}

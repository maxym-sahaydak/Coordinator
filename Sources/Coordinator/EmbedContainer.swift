//
//  File.swift
//  
//
//  Created by Maxym Sahaydak on 16.02.2020.
//

import Foundation
import UIKit

public protocol EmbedContainer {

    var view: UIView! { get }

    var viewController: UIViewController! { get }
}


extension UIViewController: EmbedContainer {

    public var viewController: UIViewController! {
        self
    }

}

extension UIView: EmbedContainer {

    public var view: UIView! {
        self
    }

    public var viewController: UIViewController! {
        viewController(for: view)
    }
}


extension UIView {
    private func viewController(for responder: UIResponder) -> UIViewController? {
        if let viewController = responder as? UIViewController {
            return viewController
        }

        if let nextResponser = responder.next {
            return viewController(for: nextResponser)
        }

        return nil
    }
}

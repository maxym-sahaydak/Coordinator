//
//  File.swift
//  
//
//  Created by Maxym Sahaydak on 16.02.2020.
//

import Foundation

public struct TransitionOptions {

    public var animated: Bool = true

    init(animated: Bool) {
        self.animated = animated
    }

    // MARK: - default

    public static var `default` = TransitionOptions(animated: true)

}

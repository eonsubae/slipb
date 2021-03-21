//
//  NSPredicate+helper.swift
//  SlipboxApp
//
//  Created by KRENGLSSEAN on 2021/03/21.
//

import Foundation
import CoreData

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}

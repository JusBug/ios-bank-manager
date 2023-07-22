//
//  Manageable.swift
//  BankManagerUIApp
//
//  Created by 박종화 on 2023/07/20.
//

import Foundation

protocol Manageable {
    var name: String { get }
    var group: [BankTask: DispatchGroup] { get }
    
    func open()
}

//extension Manageable {
//    func sortNext(to: @escaping () -> Void) {
//        group.notify(queue: .global()) {
//            to()
//        }
//    }
//}

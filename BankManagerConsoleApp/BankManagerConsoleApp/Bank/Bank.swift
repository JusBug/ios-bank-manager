//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by mint, Jusbug on 2023/07/13.
//

import Foundation

protocol BankDelegate {
    func addCustomer(_ customer: Customer)
}

final class Bank: Manageable {
    let name: String
    let group: DispatchGroup = DispatchGroup()
    private var tellers: [BankTask: Int]
    var line: [BankTask: Queue<Customer>] = [.deposit: Queue<Customer>(), .loan: Queue<Customer>()]
    private var customerNumber: Int = 1
    private var totalTime: Double = 0.0
    var bankDelegate: BankDelegate?

    init(name: String, tellers: [BankTask: Int]) {
        self.name = name
        self.tellers = tellers
    }
    
    func open() {
        operateWindow(task: .deposit)
        operateWindow(task: .loan)
    }
    
    private func randomTask() -> BankTask {
        guard let task = BankTask.allCases.randomElement() else {
            return .deposit
        }
        
        return task
    }
    
    func giveTicketNumber() {
        for number in customerNumber..<(customerNumber + 10) {
            let customer = Customer(numberTicket: number, bankTask: randomTask())
            self.bankDelegate?.addCustomer(customer)
            
            line[customer.bankTask]?.enqueue(customer)
        }
        customerNumber += 10
    }
    
    private func operateWindow(task: BankTask) {
        guard let tellerCount = tellers[task],
              let line = line[task] else {
            return
        }
        
        for _ in 1...tellerCount {
            DispatchQueue.global().async(group: group) {[weak self] in
                self?.assignCustomerTask(waitingLine: line)
            }
        }
    }
    
    private func assignCustomerTask(waitingLine: Queue<Customer>) {
        let counter: DispatchSemaphore = DispatchSemaphore(value: 1)
        var line = waitingLine
        
        while !line.isEmpty {
            counter.wait()
            guard let customer = line.dequeue() else {
                counter.signal()
                return
            }
            counter.signal()
            processCustomer(customer)
            totalTime += customer.bankTask.time
        }
    }
    
    private func processCustomer(_ customer: Customer) {
        print("\(customer.numberTicket)번 고객 \(customer.bankTask.type)업무 시작")
        Thread.sleep(forTimeInterval: customer.bankTask.time)
        print("\(customer.numberTicket)번 고객 \(customer.bankTask.type)업무 완료")
    }
    
    private func close() {
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(customerNumber)명이며, 총 업무시간은 \(String(format: "%.2f", totalTime))초입니다.")
    }
}


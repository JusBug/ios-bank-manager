//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by mint, Jusbug on 2023/07/13.
//

import Foundation

class Bank: Manageable {
    var name: String
    var tellers: (loan: Int, deposit: Int)
    private let customerNumber: Int = Int.random(in: 10...30)
    private var depositLine = Queue<Customer>()
    private var loanLine = Queue<Customer>()
    private var totalTime: Double = 0.0
    let counter = DispatchSemaphore(value: 1)
    
    init(name: String, tellers: (loan: Int, deposit: Int), depositLine: Queue<Customer> = Queue<Customer>(), loanLine: Queue<Customer> = Queue<Customer>(), totalTime: Double = 0) {
        self.name = name
        self.tellers = tellers
        self.depositLine = depositLine
        self.loanLine = loanLine
        self.totalTime = totalTime
    }
    
    func start() {
        let group = DispatchGroup()
        giveTicketNumber(numbers: customerNumber)

//        DispatchQueue.global().async(group: group) {
//            self.operateDepartment(tellerCount: self.tellers.loan, line: self.loanLine, group: group)
//            self.operateDepartment(tellerCount: self.tellers.deposit, line: self.depositLine, group: group)
//        }
        operateDepartment(tellerCount: tellers.deposit, line: depositLine, group: group)
        operateDepartment(tellerCount: tellers.loan, line: loanLine, group: group)
        group.wait()
        closeBank()
    }
    
    private func giveTicketNumber(numbers: Int) {
        for number in 1...numbers {
            let customer = Customer(numberTicket: number, bankingTask: BankingTask.allCases.randomElement() ?? .deposit)
            
            if customer.bankingTask == .deposit {
                depositLine.enqueue(customer)
            } else {
                loanLine.enqueue(customer)
            }
        }
    }
    
    private func assignCustomer(line: Queue<Customer>) {
        var line = line
        
        while !line.isEmpty {
            counter.wait()
            guard let customer = line.dequeue() else {
                counter.signal()
                return
            }
            counter.signal()
            self.processCustomer(customer)
            totalTime += customer.bankingTask.time
        }
    }
    
    private func operateDepartment(tellerCount: Int, line: Queue<Customer>, group: DispatchGroup) {
        for _ in 1...tellerCount {
            DispatchQueue.global().async(group: group) {
                self.assignCustomer(line: line)
            }
        }
    }
    
    func processCustomer(_ customer: Customer) {
        print("\(customer.numberTicket)번 고객 \(customer.bankingTask.title) 업무 시작")
        Thread.sleep(forTimeInterval: customer.bankingTask.time)
        print("\(customer.numberTicket)번 고객 \(customer.bankingTask.title) 업무 완료")
    }
    
    private func closeBank() {
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(customerNumber)명이며, 총 업무시간은 \(String(format: "%.2f", totalTime))초입니다.")
       }
}

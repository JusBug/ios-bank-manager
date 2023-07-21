# 🏦은행창구 매니저 - Jusbug🕷️, MINT😈
> 프로젝트 기간 23/07/10 ~ 23/07/21

## 📖 목차
🍀 1. [소개](#-소개) <br>
👨‍💻 2. [팀원](#-팀원) <br>
⏱️ 3. [타임라인](https://github.com/JusBug/ios-bank-manager/blob/step3/README.md#%EF%B8%8F-%ED%83%80%EC%9E%84%EB%9D%BC%EC%9D%B8) <br>
👀 4. [시각화된 프로젝트 구조](#-시각화된-프로젝트-구조) <br>
💻 5. [실행 화면](#-실행-화면) <br>
🧨 6. [트러블 슈팅](#-트러블-슈팅) <br>
📚 7. [참고 링크](#-참고-링크) <br>
👥 8. [팀 회고](#-팀-회고) <br>

</br>

## 🍀 소개
민트와 저스버그가 만든 은행창구 매니저 앱.🏦
10명에서 30명 사이의 랜덤한 고객들이 예금과 대출 업무를 처리받을 수 있습니다.

</br>

## 👨‍💻 팀원
| 🕷️Jusbug🕷️ | 😈MINT😈 |
| :--------: | :--------: |
| <Img src = "https://hackmd.io/_uploads/BJjF9oD53.jpg" width="200" height="200"> | <Img src = "https://hackmd.io/_uploads/Hy_v5sD53.jpg"  width="200" height="200"> |
|[Github Profile](https://github.com/JusBug) |[Github Profile](https://github.com/mint3382) |


</br>

## ⏱️ 타임라인
|날짜|내용|
|:--:|--|
|2023.07.10.| - Linked List Queue 구현 <br> - Unit Test 구현 |
|2023.07.11.| - concurrency 공부 |
|2023.07.12.| - Linked List와 Queue 분리 |
|2023.07.13.| - Bank, ProgramManager, Customer, Teller 구현 |
|2023.07.14.| - concurrency 공부 |
|2023.07.17.| - mutating, dispatchQueue 공부 <br> - Bank에 DispatchQueue 사용 |
|2023.07.18.| - KWDC 참여 |
|2023.07.19.| - DispatchGroup 공부, 활용 <br> - 네이밍 및 컨벤션 수정|
|2023.07.20.| - ui 구현 공부 |
|2023.07.21.| - ui 구현 <br> - autolayout 공부 |

</br>

## 👀 시각화된 프로젝트 구조
### ℹ️ File Tree
````
[BankManager]
 ├── BankManagerConsoleApp
 │   ├── main
 │   ├── Bank
 │   │   ├── BankManager
 │   │   ├── Manageable
 │   │   ├── ProgramManager
 │   │   ├── Bank
 │   │   ├── Customer
 │   │   └── BankTask
 │   └── Queue
 │       ├── Queue
 │       ├── LinkedList
 │       └── Node
 │
 |   
 └── BankManagerUIApp
     ├── Resource
     │   ├── Info
     │   └── Assets
     ├── Model
     │   ├── BankManager
     │   ├── Node
     │   ├── LinkedList
     │   ├── Queue
     │   └── Queueable
     ├── View
     │   ├── Main
     │   └── LaunchSreen
     └── Controller
         ├── AppDelegate
         ├── SceneDelegate
         └── ViewController
     
````

### 📐 Diagram
<p align="center">
<img width="800" src= "https://hackmd.io/_uploads/Skv_piw52.png" >
</br>

## 💻 실행 화면
| 1. 개점 | 2. 종료 |
|:--------:|:--------:|
|<img src="https://hackmd.io/_uploads/BJxV_sPqh.gif" width="300">|<img src="https://hackmd.io/_uploads/H18EOjvc2.gif" width="300">|<img src="" width="250">|

</br>

## 🧨 트러블 슈팅
###### 핵심 트러블 슈팅위주로 작성하였습니다.
1️⃣ **부동소수점 오류, 소수점 표현** <br>
-
🔒 **문제점🧐** <br>
totalTime을 Double로 주고 더하다 보니 부동소수점 오류로 인해 0.7에 30번 더했을 때 20.9999999가 출력되는 문제가 있었습니다. 또한 예제를 보니 7.00과 같이 소수점 두번째 자리까지 표현되어 있었습니다.

🔑 **해결방법😀** <br>
String Format을 사용하여 해결했습니다. NumberFormatter와 String Format 둘 중 고민하였는데 출력하는 부분에서만 사용하기에 String Format을 사용하였습니다. 

```swift
private func closeBank() {
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(customerNumber)명이며, 총 업무시간은 \(String(format: "%.2f", totalTime))초입니다.")
       }
```
<br>

2️⃣ **Thread.sleep(forTimeInterval: )** <br>
-
🔒 **문제점🧐** <br>
직원이 고객 1명의 업무를 처리하는데 소요되는 시간은 0.7초인데 실제로 콘솔로 실행했을 때에도 해당 시간만큼 시간이 소요되며 진행 결과를 출력해야 하는지 아니면 업무가 마감되었을 때에만 총 업무시간을 확인하면 되는지 고민하게 되었습니다.

🔑 **해결방법😀** <br>
실제로도 시간이 소요되는 것처럼 보여져야 된다고 생각하여 Thread.sleep를 이용하여 지정된 시간만큼 스레드 동작에 제한을 두어서 해결하였습니다.

```Swift
func processCustomer(_ customer: Customer) {
    print("\(customer.numberTicket)번 고객 업무 시작")
    Thread.sleep(forTimeInterval: 0.7)
    print("\(customer.numberTicket)번 고객 업무 완료")
}
```

<br>

3️⃣ **DispatchQueue, teller** <br>
-
🔒 **문제점** <br>
Teller 타입에서 해당 Teller가 처리하는 BankTask에 따라 동시에 업무를 진행하는 숫자가 달라집니다. 즉 각 Task 창구 당 Teller의 수가 작업을 처리하는 쓰레드의 수로 이해했습니다. 때문에 Teller 타입에서 어떻게 하나씩의 쓰레드를 가지고 있게 할 수 있을지 고민하였습니다. 

🔑 **해결방법** <br>
Teller 타입을 삭제하고 딕셔너리를 통해 각 BankTask key 값에 따라 value 값으로 각 task 창구 당 일하는 Teller의 숫자를 입력받아 for 문을 통해 직원의 수 만큼 쓰레드를 생성하도록 하였습니다.
```swift
private func operateWindow(task: BankTask) {
    guard let tellerCount = tellers[task],
          let line = line[task] else {
        return
    }
        
    for _ in 1...tellerCount {
        DispatchQueue.global().async(group: group) {
            self.assignCustomerTask(line: line)
        }
    }
}
```
<br>
 
4️⃣ **DispatchSemaphore** <br>
-
🔒 **문제점** <br>
DispatchQueue를 통해 쓰레드를 만들어 Teller의 수만큼 각 line의 손님에게 접근할 수 있습니다. 이때 동시다발적으로 같은 line에 접근할 수 있으므로 같은 손님을 가져다가 처리하는 race condition이 일어날 수 있는, Thread Unsafe한 상태가 만들어져 있었습니다. 

🔑 **해결방법** <br>
DispatchSemaphore를 활용하여 해결하였습니다. 동시에 접근할 수 있는 쓰레드의 개수를 1개로 지정하여 동시에 두개가 해당 line에 접근할 수 없게 보호해 주었습니다.
```swift
counter.wait()
guard let customer = line.dequeue() else {
    counter.signal()
    return
}
counter.signal()
```


5️⃣ **DispatchGroup.wait() 대신 notify()** <br>
-
🔒 **문제점** <br>
은행창구 매니저에서 업무를 처리한 후 마지막에 은행 마감 선언을 하는 부분에서 문제가 생겼습니다.  모든 업무가 다 처리된 후에 마감 처리가 들어가야 하는데 비동기로 하다 보니 마감이 중간에 들어가게 된 것으로 이를 해결하기 위해 DispatchQueue.Group을 사용하여 업무 처리하는 비동기들을 전부 넣어 주었습니다.

dispatch Group은 여러 스레드로 분배된 작업들이 끝나는 시점을 각각 파악하는 것이 아니라, 하나로 그룹지어서 한번에 파악하게 하는 것입니다. 그리고 group.wait()을 사용하면 비동기 작업들이 전부 끝나는 시점까지 현재 스레드를 멈춰서 기다리게 할 수 있습니다. 이를 사용하여 멈추고, 그 후에 close()가 불릴 수 있게 하였습니다.

그러나 group.wait()의 wait() 키워드는 상당히 위험한 키워드라는 피드백을 받았습니다. 무작정 스레드를 기다리게 하기 때문에 멈춰있는 시간동안 앱이 멈추게 되기에 main에서는 사용하면 안됩니다. 또한 그룹 내의 작업이 wait을 통해서 멈춰놓는 스레드에서 일어나는 작업이라면 Deadlock에 빠지게 됩니다.

때문에 notify()를 사용하였는데 Bank 내부에서는 순서가 제대로 지켜져서 업무가 다 끝난 후 close() 내용이 호출되지만 외부인 ProgramManager에서는 순서가 지켜지지 않았습니다.즉 programManager에서 open()에 있는 작업들이 전부 다른 스레드로 넘어가 작업되니 그 전에 미리 다시 while문이 돌아 displayMenu()가 제일 먼저 출력되어버린 것입니다.

🔑 **해결방법** <br>
Serial Queue를 이용하는 방법과 group을 밖으로 빼는 방법이 있었습니다.
- 🔥Serial Queue
custom serial queue를 하나 만들어서 그 안에서 처리가 이뤄지도록 했습니다. 다만 이 경우 처리가 조금 복잡해졌는데 Program Manager가 Bank 타입이 아닌 Manageable protocol을 알고 있기 때문에 protocol에도 serial queue와 dispatchGroup이 선언되어 있어야 했습니다.
```swift
protocol Manageable {
    var name: String { get }
    var group: DispatchGroup { get }
    var orderQueue: DispatchQueue { get }
    
    func open()
}

func open() {
    giveTicketNumber(numbers: customerNumber)
    operateWindow(task: .deposit)
    operateWindow(task: .loan)
    group.notify(queue: orderQueue) {
        self.close()
    }
}

func selectMenu() {
    displayMenu()
    while isWorking {
        guard let input = readLine() else {
            return
        }
            
        switch input {
        case Menu.startProgram.number:
            program.open()
            program.group.notify(queue: program.orderQueue) {
                self.displayMenu()
            }
        case Menu.finishProgram.number:
            isWorking = false
        default:
            print("잘못된 입력입니다. 다시 입력해주세요.")
        }
    }
}
```
그러나 이 방법의 경우 program의 프로퍼티로 들어가서 그 프로퍼티에서 메서드를 사용하는, 객체 지향 패러다임에서는 지양하는 모양의 구조로 쓰이게 됩니다. 또한 불필요했던 프로퍼티 (queue)가 하나 더 만들어졌고 기존에 private 였던 프로퍼티(group)도 열어야 했습니다.

- 🔥.global()과 extension protocol func
때문에 최대한 프로퍼티를 타고 들어가지 않기 위해 protocol manageable에서 extension으로 메서드를 구현해주었습니다.
```swift
extension Manageable {
    func sortNext(to: @escaping () -> Void) {
        group.notify(queue: .global()) {
            to()
        }
    }
}

func selectMenu() {
    displayMenu()
    while isWorking {
        guard let input = readLine() else {
            return
        }
            
        switch input {
        case Menu.startProgram.number:
            program.open()
            program.sortNext { self.displayMenu() }
        case Menu.finishProgram.number:
            isWorking = false
        default:
            print("잘못된 입력입니다. 다시 입력해주세요.")
        }
    }
}
```

<br>

## 📚 참고 링크
- [🍎Apple Docs: setTarget(queue:)](https://developer.apple.com/documentation/dispatch/dispatchobject/1452989-settarget)
- [🍎Apple Docs: DispatchQueue](https://developer.apple.com/documentation/dispatch/dispatchqueue)
- [🍎Apple Docs: Thread](https://developer.apple.com/documentation/foundation/thread)
- [🍎Apple Docs: String format](https://developer.apple.com/documentation/swift/string/init(format:_:))
- [🍎Apple Docs: escaping closure](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Escaping-Closures)
- [🍎Apple Docs: Capturing Values](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/#Capturing-Values)
- <Img src = "https://github.com/mint3382/ios-calculator-app/assets/124643545/56986ab4-dc23-4e29-bdda-f00ec1db809b" width="20"/> [야곰닷넷: 동시성 프로그래밍](https://yagom.net/courses/%EB%8F%99%EC%8B%9C%EC%84%B1-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D-concurrency-programming)



</br>

## 👥 팀 회고
- [팀 회고 링크](https://github.com/JusBug/ios-bank-manager/wiki)

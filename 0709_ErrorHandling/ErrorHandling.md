# ErrorHandling

- Swift에서 정의 하는 심각도에 따른 4가지 유형의 오류로 나눕니다.
  - Simple domain error - 단순 도메인 오류
  - recoverable - 복구 가능한 오류
  - universal error - 범용 오류
  - logic failure - 논리적 오류

<br>

<br>

## 단순 도메인 오류 - Simple domain error

- 명백하게 실패하도록 되어 있는 연산 또는 추측에 의한 실행으로 발생하는 에러입니다
  - 숫자가 아닌 문자로부터 정수를 파싱해서 발생하는 에러
  - 빈 배열에서 요소를 꺼내는 동작을해서 발생하는 에러
- 즉시 에러를 처리 할수 있는 경우가 대부분입니다.
- swift에서는 Optional Value등을 사용해서 해결하기도 합니다.

<br>

<br>

## 범용적, 보면적 오류 - Universal Error

- 시스템이나 어떤 다른 요인에 의한 오류로 이론적으로는 복구가 가능하지만 어느 지점에서 발생하는지 예상하기가 어렵습니다.

<br>

<br>

## 논리적 요류 - Logic Failure

- 프로그래머의 실수로 발생하는 오류로 프로그램적으로 컨트롤 할수 없는 오류입니다.
- 예를들어 어떠한 뷰의 Y의 값을 +10을 줘야 하는데 -10으로 줬을때 발생한다고 볼수 있습니다.
- 시스템에 메시지를 남기고 alert()을 호출하거나 Exception(예외)이 발생합니다.

<br>

<br>

## 복구 가능한 오류 - Recoverable

- 미리 오류를 합리적으로 예측하여 방지가 가능한 오류입니다.
- iOS에서는 NSError 또는 Error을 통해서 처리가 가능합니다.
- 무시를 하면 좋지 않거나 위험할수 있으므로 예측하여 방지하는 코드를 작성합니다.
- 오류의 내용을 유저에게 알려주거나, 다시 해당 오류를 처리하는 코드를 수행하여 처리하는 것이 일반적인 사용처입니다.

<br>

<br>

## Error Handling은 어떤 Error에 사용하는 걸까?

- 단순 도메인 오류는 Optional Vlaue 등을 사용해서 처리합니다.
- 논리적 오류는 프로그래머에게서 발생할 가능성이 높습니다.
- 범용적, 보편적 오류는 시스템에서 발생기에 어느 지점에서 발생하는지 예상하기가 어려워서 미리 예측이 불가능 합니다.
- 그래서 Error Handling은 복구 가능한 오류 (합리적으로 예측하여 방지가 가능한 오류)들에 사용합니다.

<br>

<br>

## 에러 핸들링을 위한 방법 - Ways th handle errors

- 4가지 방법이 있습니다.
  - Handling Errors Using Do-Catch - [ Do-Catch을 사용한 방법 ]
  - Propagation Errors Using Throwing Functions - [ 오류 전파를 통한 방법 ]
  - Converting Errors to Optional Values - [ OPtional Values를 사용하는 방법 ]
  - Disabling Error Propagation - [ 오류 전파를 사용하지 않는 방법 ]
- 4가지 방법에 대해서 조금더 자세하게 알아보면 다음과 같습니다.

<br>

<br>

## Handling Errors Using Do-Catch

- Do-Catch를 사용해서 ErrorHandling을 하는 방법입니다.

```swift
import UIKit

final class ViewController: UIViewController {

    private let tmpDir = NSTemporaryDirectory()
    private let filePath = NSTemporaryDirectory() + "swift.txt"
    private let errorFilePath = NSTemporaryDirectory() + "errorFile.txt"

    override func viewDidLoad() {
        super.viewDidLoad()
        tmpDirbasic()
        filePathbasic2()
    }

    private func tmpDirbasic() {
        let swift = "Swift Error Handling"
        do {
            try swift.write(toFile: tmpDir, atomically: true, encoding: .utf8)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
        private funcfilePath basic2() {
        let swift = "Swift Error Handling"
        do {
            try swift.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
```

- Error을 발생시키기 위해서 `let swift = "Swift Error Handling"` 을 만들어 준뒤에 tmpDir(디렉토리), filePath(파일경로)에 write를 해줬습니다.

- `try swift.write(toFile: tmpDir, atomically: true, encoding: .utf8)` 는 디렉토리에 swift를 쓰려고 했기 때문에 에러가 발생하면서 catch에 있는 문장이 실행됩니다.

- `try swift.write(toFile: filePath, atomically: true, encoding: .utf8)` 는 저장될 파일 경로를 지정해 준거기 때문에 에러가 발생하지 않아서 별다른 문장을 출력하지 않습니다.

- swift.write()의 앞에 try를 써준 이유는 throws 키워드와 do-catch문때문입니다.

  ```swift
  swift.write(toFile: <StringProtocol>, atomically: <Bool>, encoding: <String.Encoding>) throws
  ```

- Throws 키워드를 사용하기 위해서는 try를 붙여줘야 합니다. 그런데 try는 단독으로 사용이 불가능 하고 do-catch와 같이 사용해 줘야 합니다.( try!, try?의 경우는 다릅니다.)

- 기본적인 do-catch에서 try를 사용해서 Error Handling을 하는 방법입니다.

<br>

<br>

### 그럼 do catch에 에러가 발생하는 메서드와 발생하지 않는 메서드가 같이 있으면 어떻게 될까?

- do - catch에 try를 사용해서 error handling을 해주면 에러가 발생하면 catch이 실행되고 발생하지 않으면 method가 순서대로 실행 된뒤에 종료 되었습니다.

```swift
import UIKit

final class ViewController: UIViewController {

    private let tmpDir = NSTemporaryDirectory()
    private let filePath = NSTemporaryDirectory() + "swift.txt"

    override func viewDidLoad() {
        super.viewDidLoad()
        basic()
    }

    private func basic() {
        let swift = "Swift Error Handling"
        do {
            try swift.write(toFile: tmpDir, atomically: true, encoding: .utf8)	// 에러
            try swift.write(toFile: filePath, atomically: true, encoding: .utf8) // 정상
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
```

- 위의 예제는 에러가 발생하는 `try swift.write(toFile: tmpDir, atomically: true, encoding: .utf8)` 가 위에 있는 상황입니다. 
- 이 상황에서는 에러가 발생하기 때문에 바로 아래 문장인 `try swift.write(toFile: filePath, atomically: true, encoding: .utf8)`가 실행되지 않고 catch 문으로 넘어가 `print(error)와 print(error.localizedDescription)` 를 실행하게 됩니다.

```swift
try swift.write(toFile: filePath, atomically: true, encoding: .utf8)	// 정상
try swift.write(toFile: tmpDir, atomically: true, encoding: .utf8)		// 에러
```

- 만약 위에 처럼 순서를 바꿔주게 된다면 `try swift.write(toFile: filePath, atomically: true, encoding: .utf8)` 가 실행되고 `try swift.write(toFile: tmpDir, atomically: true, encoding: .utf8)`가 실행되면서 catch문이 실행된뒤에 method가 종료하게 됩니다.
- 이처럼 Error가 발생하게 되는 구문이 위에 있으면 아래 있는 구문은 실행되지 않는다는 점을 주의해야 합니다.

<br>

<br>

## Converting Errors to Optional Values

- `try?` 를 사용해서 Error Handling을 하는 방법입니다.
- `try?` 를 사용하여 do ~ catch 구문 없이 오류 처리가 가능하며 가능 정상 수행 시 Optional 값 반환합니다.
- 오류 발생 시에는 nil 반환합니다.

```swift
import UIKit

final class ViewController: UIViewController {

    private let tmpDir = NSTemporaryDirectory()
    private let filePath = NSTemporaryDirectory() + "swift.txt"

    override func viewDidLoad() {
        super.viewDidLoad()
        createDummyFile()
    }

    private func createDummyFile() {
        let swift = "Swift Error Handling"
        try? swift.write(toFile: filePath, atomically: true, encoding: .utf8)
    }
}
```

- 위에서` try`는 throws의 키워드의 에러를 받는 쪽에서 사용되며 do-catch 내부에서 사용해야 한다고 했습니다.

- `try?` 는 에러가 발생하면 method를 실행해서 에러가 발생하면 nil을 반환합니다.

- 예제에서 사용한 `try? swift.write(toFile: filePath, atomically: true, encoding: .utf8)` 는 다음과 같습니다.

  ```swift
  // 두 구문은 같은 표현입니다.
  try? swift.write(toFile: filePath, atomically: true, encoding: .utf8)
  
  do {
      try swift.write(toFile: filePath, atomically: true, encoding: .utf8)
  } catch {
      nil
  }
  ```

- 주의사항으로는 do-catch문에서 실행하게 되면 에러를 반환하는게 아니라 nil을 반환하게 되므로 catch문이 실행되지 않습니다.

```swift
private func basic() {
    let swift = "Swift Error Handling"
    do {
        try? swift.write(toFile: tmpDir, atomically: true, encoding: .utf8)	// nil 반환
        try swift.write(toFile: filePath, atomically: true, encoding: .utf8)
    } catch {
        print(error)
        print(error.localizedDescription)
    }
```

- `try? swift.write(toFile: tmpDir, atomically: true, encoding: .utf8)` 를 해줬기 때문에 catch문이 실행되는게 아닌 nil을 반환하게 됩니다.

<br>

<br>

## Disabling Error Propagatio - try!

- do ~ catch 구문 없이 throws 메서드 처리 가능하지만 오류 발생 시 앱 Crash 날수 있습니다.

- 오류가 발생하지 않는다고 확신할 수 있는 경우(예를들면 앱 번들에 함께 제공되는 이미지를 로드하는 경우)에만 try! 사용합니다. 

  ```swift
  let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
  ```

- 에러가 발생하는 `String(contentsOfFile: errorFilePath)` 구문을 만들어서 `try!` 의 동작을 알아보겠습니다.

```swift
do {
    _ = try! String(contentsOfFile: errorFilePath)
    _ = try? String(contentsOfFile: errorFilePath)
    _ = try String(contentsOfFile: errorFilePath)
} catch {
    print(error)
}
```

- `_ = try! String(contentsOfFile: errorFilePath)` 이기 때문에 앱이 Crash가 발생합니다.

- `try!`는 에러가 발생하지 않는다고 확신할수 있는 경우에만 사용해야 하는데 에러가 발생했기 때문입니다.

  <br>

  <br>

- 추가로 try, try?의 위치에 따른 실행결과를 보면 다음과 같습니다.

```swift
do {
    _ = try String(contentsOfFile: errorFilePath)
 	_ = try? String(contentsOfFile: errorFilePath)
} catch {
    print(error)
}
```

- `_ = try String(contentsOfFile: errorFilePath)` 가 실행되어서 catch가 실행됩니다.
- `_ = try? String(contentsOfFile: errorFilePath)` 는 실행되지 않습니다.

```swift
do {
	_ = try? String(contentsOfFile: errorFilePath)
    _ = try String(contentsOfFile: errorFilePath)
} catch {
    print(error)
}
```

- `_ = try? String(contentsOfFile: errorFilePath)` 는 nil을 반환합니다.
- `_ = try String(contentsOfFile: errorFilePath)` 는 catch구문을 실행합니다.

<br>

<br>

## Propagation Errors Using Throwing Functions

- method 뒤에 throws를 사용하면 오류에 대한 처리를 코드의 다른 부분에서 처리하도록 명시적으로 선언해 줍니다.
- throws 키워드가 없을 때는 오류를 해당 함수 내에서 처리해야 합니다.

```swift
final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        throwsFunctionExample()
    }
    
    private func throwsFunctionExample() {
        do {
            try throwNSError() 
        } catch {
            print("Error :", error)
            print("Error LocalizedDescription :", error.localizedDescription)

            let e = error as NSError 
            print("nserror :", e)
            print("domain :", e.domain)
            print("code :", e.code)
            print("userInfo :", e.userInfo)
        }

        private func throwNSError() throws {
            throw NSError(domain: "domain data", code: 55, userInfo: ["something": 1])
        }
    }
}
```

- throwsFunctionExample()을 실행하면 throwNSError()가 실행됩니다.
- Method throwNSError()는 NSError을 가지고 있지만 내부에서 Error Handling을 하지 않아도 된다는 키워드 throws를 가지고 있습니다.
- 그렇기 때문에 `private func throwNSError() throws { }` 에서 에러가 발생하면  `try throwNSError()` 로 가져와서 `throwsFunctionExample ()`에서 에러를 처리합니다.
- 에러를 넘겨줄때 NSError로 정보를 같이 넘겨줬기 때문에 NSError로 타입캐스팅을 해서 세부 정보를 읽어 올수 있습니다. 

<br>

<br>

## Custom Propagation Errors Using Throwing Functions

- 에러의 케이스를 직접 만들어서 사용도 가능합니다.

```swift
final class ViewController: UIViewController {

    enum MyError: Error {
        case errorExample
        case errorWithParam(num: Int)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        throwsFunctionExample()
    }
    
    private func throwsFunctionExample() {
        do {
            try throwNSError()
        } catch {
            print("Error :", error)
            print("Error LocalizedDescription :", error.localizedDescription)

            let e = error as NSError
            print("nserror :", e)
            print("domain :", e.domain)
            print("code :", e.code)
            print("userInfo :", e.userInfo)
        }

        do {
            try throwError()
        } catch let err {
            print("Error :", err)
            print("Error LocalizedDescription :", err.localizedDescription)

            let e = err as NSError 
            print("nserror :", e)
            print("domain :", e.domain)
            print("code :", e.code)
            print("userInfo :", e.userInfo)
        }

        do {
            try throwError()
        } catch MyError.errorExample {
            print("errorExample")
        } catch MyError.errorWithParam(let num) {
            print("error with number param:", num)
        } catch {
            print("The error is not MyError")
        }
    }
    private func throwError() throws {
        throw MyError.errorWithParam(num: 10)
    }
}
```

- 위의 예제는 enum을 사용해서 에러의 case를 직접 만들어 줬습니다.

  ```swift
  enum MyError: Error {
      case errorExample
      case errorWithParam(num: Int)
  }
  ```

  `throwsFunctionExample()`가 실행되면서 `throwError() method`가 실행되면 에러가 발생하면서 try `hrowNSError()` 에게 에러를 넘기게 됩니다.

  ```swift
  private func throwError() throws {
      throw MyError.errorWithParam(num: 10)
  }
  ```

- 이전 예제와 차이점은 NSError로 넘긴게 아니기 때문에 NSError로 타입캐스팅은 되지만 세부 정보는 나오지 않는다는 점입니다..

- 세부 정보를 보고 싶으면 선언해준 error의 enum 타입의 case를 do - catch의 case로 사용해서 확인 하는 방법이 있습니다.

<br>

<br>

## rethrows를 사용해서 

- throwing 함수를 인자로 취하는 함수는 rethrows를 사용 가능합니다.
- rethrows를 선언한 함수는 반드시 매개변수 중 하나 이상에 throwing가  포함되어 있어야 합니다.
- thrwos와 역할은 동일하나 사용에 있어서 차이가 있습니다.

```swift
import UIKit

final class ViewController: UIViewController {

    private let tmpDir = NSTemporaryDirectory()
    private let filePath = NSTemporaryDirectory() + "swift.txt"
    private let errorFilePath = NSTemporaryDirectory() + "errorFile.txt"

    enum MyError: Error {
        case errorExample
        case errorWithParam(num: Int)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rethrowsFunctionExample()
    }
    private func rethrowsFunctionExample() {
        someRethrowsFunction ({ })

        do {
            try someRethrowsFunction {
                // ...
                throw MyError.errorExample
            }
        } catch {
            print(error)
        }
    }
    private func someRethrowsFunction(_ fn: () throws -> ()) rethrows {
        try fn()
    }
}
```

- `rethrowsFunctionExample()` 을 실행하면 `someRethrowsFunction ({ })` 게 실행되면서 다음과 같이 실행됩니다.

- `private func someRethrowsFunction(_ fn: () throws -> ()) rethrows { }` 는 throws 키워드로 fn()을 parameter로 가지는 method입니다. 

- 그리고 이 메서드는 rethrows를 가지고 있기 때문에 내부에서 에러를 해결하지 않고 외부로 전달해서 처리할수 있습니다.

  ```swift
  private func someRethrowsFunction(_ fn: () throws -> ()) rethrows {
      try fn()
  }
  ```

- 다시 한번 보면 throws 키워드를 가지고 있고 발생한 에러를 rethrows 키워드를 통해서 외부에서 처리 할수도 있다고 했기 때문에 try fn()만 해줘도 됩니다.

- 만약 rethrows가 없었다면 throws 키워드를 가지는 fn()를 처리해주기 위해서 try? 를 사용하거나 do-catch를 사용했어야 합니다.

-  그래서 rethrows을 해줬기 때문에 외부에서 에러를 핸들링하기 위해 `someRethrowsFunction{}` 가 사용되는 scope내에 do - catch를 만들어 줬습니다.

  <br>

- 그리고 throws function은 non-throws function보다 작은 범위로 봐야 하기 대문에 throws나 rethrows 키워드를 사용했다 하더라도 내부에서 try?나 do - catch를 사용해서 처리해줄수 있습니다. (무조건 외부로 던져서 처리하는건 아닙니다.)

  ```swift
  // try?
  try? someThrowsFunction()
  // do - catch
  do {
      try fn()
  } catch {
      print("nested error :", error)
  }
  ```

- 위와 같이 내부에서 처리할 경우에는 외부에 만들어 놓은 Error handling이 동작하지 않다는 것을 다시 한번 주의해야 합니다.

<br>

<br>

## 종료할때 처리하는 액션 - Defer

- 현재 코드 블럭이 종료되기 직전에 반드시 실행되어야 하는 코드를 등록해 놓고 사용하는 방법입니다.
- 해당 범위가 종료될 때까지 실행을 연기하면서 소스 코드에 기록된 순서의 역순으로 동작하게 됩니다.

```swift
  private func deferOrder() {
    print("start")
    defer { print("defer1") }
    print("center")
    defer { print("defer2") }
    defer { print("defer3") }
    print("end")
  }
```

- 위의 예제의 실행순서를 보면 다음과 같습니다.
  1. start
  2. center
  3. end
  4. defer3
  5. defer2
  6. defer1
- 위와 같이 defer을 제외한 나머지가 실행 된 뒤에 defer이 역순으로 실행됩니다.

<br>

- Error Handling과 같이 보면 다음과 같습니다.

```swift
import UIKit

final class ViewController: UIViewController {

    private let tmpDir = NSTemporaryDirectory()
    private let filePath = NSTemporaryDirectory() + "swift.txt"
    private let errorFilePath = NSTemporaryDirectory() + "errorFile.txt"

    enum MyError: Error {
        case errorExample
        case errorWithParam(num: Int)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        deferExample()
    }

    private func throwError() throws {
        throw MyError.errorWithParam(num: 10)
    }
    
      private func deferExample() {
    defer { print("task1 - Must do something before return") }
    do {
      try throwError()
    } catch {
      print(error)
      return
    }
          
    // Do something here if no error occurred
    print("This is not called when error occurred")
    defer {
      print("This is not called when error occurred")
    }
  }
}
```

- deferExample() 메소드를 실행하면 다음과 같습니다.
  1. `defer { print("task1 - Must do something before return") }` 는 Scope가 완료되고 실행됩니다.
  2. try throwError() 에 error이 있기 때문에 catch로 이동해서 error의 내용 `errorWithParam(num: 10)`를 출력합니다.
  3. 그 뒤 return을 만나 반환하면서 defer에 넣어놨던 문장("task1 - Must do something before return")이 출력되면서 method가 종료됩니다.
- 만약 try throwError()가 에러가 아니라면
  1. `defer { print("task1 - Must do something before return") }` 는 Scope가 완료되고 실행됩니다.
  2. `print("This is not called when error occurred")` 를 출력합니다.
  3. `defer { print("This is not called when error occurred")`  는 Scope가 완료되고 실행됩니다.
  4. method가 종료되면서 `"This is not called when error occurred"` 이 출력됩니다.
  5. 제일 처음에 담아 두었던 `"task1 - Must do something before return"` 가 출력됩니다.
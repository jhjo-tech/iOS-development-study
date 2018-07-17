# MetaType

- Metatype > Type > Instance

- String Metatype > String Type > String Instance

  `let str = "String"` 에서

  `str` 은 struct String의 객체

  `String` 은 struct String 타입의 인스턴스 (타입 자체에 대한 참조)

  `String.type` 은 String의 Metatype

  이라고 볼수 있습니다.

<br>

<br>

## String으로 보는 Metatype

```swift
let swiftString = Swift.String.init("initString")
print(swiftStirng)	// "initString"
```

	- `initString`는 인스턴스이며, String의 객체입니다.

```swift
let swiftStringSelf = Swift.String.self
print(swiftStringSelf)	// String
```

- `String.self` 는 `String` 와 같습니다.
- String은 Struct인데 String.self를 하면 Struct 자체를 참조하는 것과 같습니다. (타입 자체에 접근한다고 볼수 있습니다.)

```swift
let swiftStringType = type(of: Swift.String.init("initString"))
print(swiftStringType)	// String

let swiftStringMetatype = type(of: Swift.String.self)
print(swiftStringMetatype)	// String.Type
```

- 각각의 타입을 찍어보면 다음과 같습니다.
- String의 객체인 "initString"는 String입니다.
- String.self로 String Struct를 참조해서 찍어보면 String.Type입니다.

<br>

```swift
let str: String = "myString"
let stringSelf: String = "myString".self
let stringType: String.Type = type(of: "mystring")
let stringMetatype: String.Type.Type = type(of: type(of: "myString"))
```

- "myString"는 String의 객체이기 때문에 : String 타입을 받습니다.
- "myString".self는 String을 말하기 때문에 :String 타입을 받습니다.
- type(of: "mystring")은 String.Type을 반환하기 때문에 : String.Type 타입을 받습니다.
- type(of: type(of: "myString")) 은 String.Type의 Type을 반환하기 때문에 : String.Type.Type 타입을 받습니다.

<br>

<br>

## Generic을 사용해서 타입 확인

```swift
private func printType<T>(of type: T.Type) {
    print("\(type)")
}
```

- Type을 받아서 출력하는 Generic Functrion이 있습니다.

<br>

```swift
private func printType<T>(of type: T.Type) {
  print("\(type)")
}
printType(of: Int.self)
printType(of: type(of: 10))
printType(of: type(of: Int.self)) 
```

- printType(of: Int.self)는 Int.Type이 함수의 인자로 들어가서 Int가 출력됩니다.
- printType(of: type(of: 10))에서 type(of: 10)는 Int이고 printType(of: Int.self)가 되면 Int.Type가 함수의 인자로 들어가서 Int가 출력됩니다.
- printType(of: type(of: Int.self))에서 type(of: Int.self)은 Int.Type이고 printType(of: Int.Type)이 되면 Int.Type.Type이 함수의 인자로 들어가면서 Int.Type가 출력됩니다.

<br>

<br>

## as Any

- Any 타입은 시스템에서 정해진 타입으로만 타입 캐스팅이 가능합니다.

```swift
protocol P {}
extension String: P {}

let stringAsP: P = "Hello!"

func printGenericInfo<T>(_ value: T) {
  let valueType = type(of: value)
  print("'\(value)' of type '\(valueType)'")
}

func betterPrintGenericInfo<T>(_ value: T) {
  let valueType = type(of: value as Any)
  print("'\(value)' of type '\(valueType)'")
}
```

- 예제를 하나씩 보면 다음과 같습니다.

  ```swift
  protocol P {}
  extension String: P {}
  
  let stringAsP: P = "Hello!"
  ```

  - protocol P가 있고 extension으로 String이 protocol P 사용할수 있도록 했습니다.
  - `let stringAsP: P = "Hello!"` 를 해서 P의 객체 "Hello!"를 stringAsP에 넣었습니다.

  ```swift
  func printGenericInfo<T>(_ value: T) {
    let valueType = type(of: value)
    print("'\(value)' of type '\(valueType)'")
  }
  ```

  - function printGenericInfo() 는 Parameter를 받아와서 그 타입을 상수에 담에 Parameter와 타입을 출력하는 함수입니다.

  ```swift
  func betterPrintGenericInfo<T>(_ value: T) {
    let valueType = type(of: value as Any)
    print("'\(value)' of type '\(valueType)'")
  }
  ```

  - function betterPrintGenericInfo()는 Parameter를 받아서 Any 타입으로 타입캐스팅 한 다음 상수에 담아 Parameter와 캐스팅 된 타입을 출력하는 함수입니다.

  ```swift
  printGenericInfo(stringAsP)			// 'Hello!' of type 'P'
  betterPrintGenericInfo(stringAsP)	// 'Hello!' of type 'String'
  ```

  - 왜 2개의 결과값이 다른걸까?
  - 먼저 `let valueType = type(of: value)` 는 static type으로 P를 해줬기 때문에 type을 P로 출력합니다.
  - let valueType = type(of: value as Any) 는 static type P로 들어왔는데, Any로 타입캐스팅을 해줬기 때문에 P인지 아닌지 알수 없습니다. 그래서 기본적으로 가지고 있는 String을 출력하게 됩니다.
  - 타입관련해서 사용할때 타입 캐스팅을 주의해서 사용해야 할것 같습니다.

<br>

<br>

## Type 간의 비교

- == 는 인스턴스끼리 값을 비교합니다.
- is는 타입을 비교합니다. 예를들어 3 is Int는 3은 Int의 인스턴스인가요? 와 같습니다.

```swift
let str = "StringInstance"
print(str is String)
print(str == "StringInstance") 
print(str is String.Type)
print(str is String.Type.Type)
```

- 하나씩 보면 다음과 같습니다.

  ```swift
  print(str is String) 
  ```

  - str은 "StringInstance"를 가지고 있습니다.  "StringInstance"는 String Type의 객체입니다. 그렇기 때문에 str은 String의 인스턴스는 참이 됩니다.

  ```swift
  print(str == "StringInstance")
  ```

  - == 는 인스턴스끼리의 값을 비교합니다. str은 String Type의 객체 "StringInstance"를 가지고 있기 때문에 값을 비교 했을때 참이 됩니다.

  ```swift
  print(str is String.Type)
  ```

  - str은 String Type의 인스턴스를 가지고 있기 때문에 String이 됩니다. String.Type는 String의 MetaType이기 때문에 거짓이 출력됩니다.

  ```swift
  print(str is String.Type.Type)
  ```

  - str은 String Type의 인스턴스를 가지고 있기 때문에 String이 됩니다. 그렇기 때문에 String의  Metatype의 Metatype의 인스턴스냐는 질문은 거짓이 됩니다.

- 이와 같은 방법을 사용해서 Type 간의 비교를 할수 있음을 알게 되었습니다.

<br>

- 인스턴스가 아닌 Type을 가지고 다시 한번 보면 다음과 같습니다.

  ```swift
  private let meta = type(of: String.self)        // String.Type.Type
  print(meta is String)  // false
  print(meta == String.self)  // false
  print(meta == String.Type.self)  // true, String 메타타입은 String.Type
  print(meta is String.Type.Type)  // true, String 메타타입은 String.Type.Type 의 객체
  ```

  - `let meta` 는 String.self(String)의 타입인 String.Type을 가지고 있는 상수입니다.

  ```swift
  print(meta is String)
  ```

  - `meta`는 String.Type이기 때문에 String의 인스턴스는 아닙니다. 그래서 False가 출력됩니다.

  ```swift
  print(meta == String.self)
  ```

  - meta는 String.Type이고 String.self는 String이므로 False가 출력됩니다.

  ```swift
  print(meta == String.Type.self)
  ```

  - meta는 String.Type이고 String.Type.self는 String.Type이므로 True가 출력됩니다.

  ```swift
  print(meta is String.Type.Type)
  ```

  - meta는 String.Type이고 String.Type.Type은 String.Type.Type입니다.
  - String.Type.Type은 String.Type의 Metatype입니다.
  - 그래서 String.Type은 String.Type.Type의 인스턴스 이므로 결과는 True가 출력됩니다.

<br>

<br>

## Metatype에 따른 호출

- 다음과 같은 예제가 있습니다.

```swift
final class A {
    static var somthing = 5
    var someProp = 5
}

let s1 = A()
s1.someProp = 10
let s2 = A()
s2.someProp = 8
s1.someProp			// 10
s2.someProp			// 8

A.somthing = 10
A.somthing = 8
A.somthing			// 8
```

- s1은 A의 인스턴스입니다. 인스턴스에서는 someProp는 접근이 가능한데 somthing는 접근이 가능하지 않습니다.
- 이유는 init를 하면 Type -> Instance로 인스턴스화 되어서 여러번 인스턴스화를 하면 각각 사용할수 있게 됩니다. 그러나 static으로 선언한 변수는 Metatype -> Type으로 되고 이는 단 1개의 객체만 존재하게 만들어  여러번 인스턴스화를 해도 객체에 1개만 남게 됩니다. 
- 이것을 전역변수라고 합니다. 전역변수는 인스턴스화를 해주지 않아도 값에 접근하여 변경이 가능합니다.

<br>

```swift
final class A {
    func instanceMethod() { print("instance") }
    func instanceMethodWithNumber(_ number: Int) { print("Number :", number) }
}

let aInstance = A()
aInstance.instanceMethodWithNumber(5)
A.instanceMethodWithNumber(aInstance)(5)
type(of: aInstance).instanceMethodWithNumber(aInstance)(5)

aInstance.instanceMethod()
A.instanceMethod(aInstance)
```

- aInstance는 A의 인스턴스입니다.
- 인스턴스에서는 function에 대한 접근을 바로 할수 있습니다.
- A.self 상태에서는 function을 사용하려면 A의 인스턴스가 필요합니다.

<br>

```swift
final class A {
    static func staticMethod() { print("Type Method(static func)") } 
    class func classMethod() { print("Type Method(class func)") } 
}

let aInstance = A()
type(of: aInstance).classMethod() 
A.staticMethod()				
A.classMethod()
```

- type(of: aInstance)와 A는 같습니다.

<br>

<br>

## Metatype 실제 사용 예제

- 실제로 Metatype이 사용되는 예제입니다.

1. JSONDecoder decode

```swift
open class JSONDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}
e.g. try JSONDecoder().decode(MyClass.self, from: data)
```

- Json의 Data를 Metatype으로 받을수 있습니다.

<br>

2. UITableView Dynamic Cell Register

```swift
tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
e.g. CustomCell.identifier  -> "CustomCell"
```

- tableView의 cell을 정의해줄때 customcell을 만들어서 Metatype으로 사용할수 있습니다.

<br>

3. UITableViewCell identifier extension

```swift
extension UITableViewCell: TableViewCellType {
    static var identifier: String { return String(describing: self.self) }
}
```

<br>

4. Storyboard instantiate extension

```swift
extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}
```


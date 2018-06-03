# 0531



### What can I Konw?

- Functional Reactive Programming Paradigm
- a



<br>

<br>

### High - order Function - 고차함수

#### 고차 함수란?

> 하나이상의 함수를 인자로 취하는 함수이자 함수를 결과로 반환하는 함수입니다.
>
> (함수를 하나의 변수로 사용하겠다.)

​	High-order Function이 되기 위해서는 함수가 First-class Citizne 이어야 합니다.

<br>

####First-class Citizne - 1급 객체

> 변수나 데이터에 할당할 수 있어야 합니다.
>
> 객체의 인자로 넘길 수 있어야 합니다.
>
> 객체의 리턴값으로 리턴할 수 있어야 합니다.



```swift
func firstCitizen() {
 print("function call")
 }

 func function(_ parameter: @escaping ()->()) -> (()->()) {
 return parameter
 }

 let returnValue = function(firstCitizen)
 returnValue()
```

Function안에 Function이 있습니다.

Functional 하다는 것은 Function안에 Function을 인자로 사용할수 있다는 말입니다.

```swfit
 let returnValue = function(firstCitizen)
```



#### Example로 보는 First-class Citizne

다음은 각각 중첩 function과 Closure로 표현한 Function입니다.

```swift
// 중첩 function
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
	var runningTotal = 0
	func incrementer() -> Int {
		runningTotal += amount
		return runningTotal
	}
	return incrementer // 리턴값
}

// Closure
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
	var runningTotal = 0
	return {
		runningTotal += amount
		return runningTotal
	}
}

let incrementer = makeIncrementer(forIncrement: 7) // 변수에 할당
print(incrementer())  // 7
print(incrementer())  // 14
```

Function은 First-class Citizen으로 변수로 할당해서 사용이 가능합니다.



#####Clouser, 넌 대체 누구니?

위의 코드를 보면 알겠지만, function을 중첩해서 사용하는것보다 Clouser를 사용하면 좀 더 간결하게 표현할수 있습니다.

Clouser는

> 실행 가능한 코드 블럭입니다.
>
> Function과는 다르게 이름을 정의할 필요는 없지만, Parameter와 return이 존재할수 있다는건 같습니다.
>
> Function은 이름이 있는 Clouser입니다.
>
> First-class Citizen으로 변수, 상수에 할당할수 있고, 객체의 인자로 넘길수 있고, 리턴값으로 리턴도 가능합니다.



##### Clouser Syntax

> Clouser는 중괄호 { }로 감싸져 있습니다.
>
> 괄호 () 이용해서 parameter(인자)를 정의합니다.
>
> -> 키워드를 사용해서 반환 타입을 명시합니다.
>
> "in" 키워드를 사용해서 실행코드와 분리합니다.

```swift
{(매개변수 목록) -> 반환타입 in return 실행코드 }
```

```swift
let sum: (Int, Int) -> (Int) = {(num1: Int, num2: Int) -> Int in
    return num1 + num2
}

let sumResult: Int = sum(1, 2)
print(sumResult)    // 3
```



##### Clouser 축약

Array[String]을 Type으로 가지는 상수 names를 .sorted() 함수를 사용해서 정렬을 시켰습니다.

위에서 Function은 이름이 있는 Clouser입니다.

```swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
names.sorted() = ["Alex", "Barry", "Chris", "Daniella", "Ewa"]
```

그렇기 때문에 다음과 같이 Clouser로 만드는것이 가능합니다.

```swift
names.sorted(by: (String, String) throws -> Bool)
```

```swift
names.sorted { (String, String) -> Bool in
    code
}
```

```swift
name.sorted { (str1: String, str2: String) -> Bool in
	return str1 < str2
}
```



이렇게 만들어진 Clouser는 축약을 할 수 있습니다.

```swift
name.sorted { (str1, str2) -> Bool in
    return str1 < str2
}
```

```swift
name.sorted { str1, str2 in return str1 < str2 }
```

```swift
name.sorted { str1, str2 in str1 < str2 }
```

```swfit
name.sorted {$0 < $1}
```

```swift
name.sorted (by: <)
```

너무 많은 축약은 협업을 하는 개발자가 알아 볼수 없지만, 통상적으로 사용하는 고차함수들은 축약을 해서 사용하는것 같다.



##### function Parameter로써의 Clouser

```swift
func sortFunction(s1: String, s2: String) -> Bool {
    return s1 > s2
}
names.sorted(by: sortFunction(s1:s2:))
```

이렇듯 Clouser은 Function의 parameter로도 변수로도 넣을수 있기 때문에 1급객체라고 합니다.



다시 Hight-order Furnction으로 돌아가서



<br>

<br>

### Swift 내에서의 High-order Function

High-order Function은 Collection Type을 사용해서 반환하거나 새로운 형태로 만들거나 병합하는 등과 같은 작업을 할수 있습니다. 

시퀸스 (프로토콜로 구성되어 있으며, range colllection이 포함된다.)

- forEach
- map
- filter
- reduce
- flatMap
- compactMap



#### Collection Type

![CollectionTypes_intro](./img/CollectionTypes_intro.png)



<br>

<br>

#### forEach

> 순서에 따라 for-in lopp로 값을 호출하며, 반환값이 있습니다.

기본적인 .forEach의 Syntax입니다.

```swift
immutableArray.forEach((Int) throws -> Void)

immutableArray.forEach { (Int) in
    code
}
```

익숙한 for문으로 작성해서 .forEach를 비교 했을때입니다.

String으로 받았을때는 차이가 없습니다.

```swift
let numberWords = ["one", "two", "three"]
for word in numberWords {
    print(word)
}
// Prints "one"
// Prints "two"
// Prints "three"

numberWords.forEach { word in
    print(word)
}
// Same as above
```

1~10 까지의 숫자 중 짝수만 출력하다가 9가 되면 종료되도록 for문과 forEach문을 사용해서 만들어 보면 차이가 보입니다.

```swift
for i in 1...10 {
    guard i != 9 else { break }
    guard i % 2 == 0 else { continue }
    print(i)	// 2 4 6 8
}

(1...10).forEach {
    guard $0 != 9 else { return }
    if $0 % 2 == 0 {
        print($0) // 2 4 6 8 10
    }
}
```

for문은 결과값이 2, 4, 6, 8까지 나왔는데, 같은 guard문을 사용한 .forEach는 2, 4, 6, 8, 10이 출력되었습니다.

이는 break를 사용할수 있냐 없냐의 차이인데, break는 for, while과 같은 반복문에서만 사용이 가능합니다. (.forEach에서 사용하면 에러가 발생합니다.)

그래서 9가들어왔을때 return을 해주고 .forEach로 돌아가서 남은 10까지 들어오게 된것입니다.

그래서 .forEach에서 9가되면 종료가 되게 하려면 이렇게 해줘야합니다.

```swift
(1...10).forEach {
    guard $0 < 9 else { return }
    if $0 % 2 == 0 {
        print($0) // 2 4 6 8 10
    }
}
```

.forEach는 sequence의 element(요소)를 parameter(매개변수)로 사용하는 Closure이고, printParm(_:) Function은 Swift에서 1급객체이기 때문에 변수와 상수에 할당 할수 있고, 객체의 인자로도 사용할 수 있습니다.

여기서는 .forEach에 printParm(_:) Function을 인자로 준 예제입니다.

```swift
// Function
let immutableArray = [1, 2, 3, 4]

// 인자값으로 들어온 값들을 출력하는 함수
func printParm(_ num: Int) {
    print(num, terminator: " ")
}

//.forEach는 PrintParn(_:) Function을 인자값으로 줬습니다.
//Function은 1급객체기 때문에 함수, 클로저의 인자로 줄수 있습니다.
immutableArray.forEach(printParm(_:))
```

.forEach를 통해서 immutableArray의 값이 1개씩 printParm(_:)으로 들어가게 되고,

printParm(_:)을 통해서 출력을 하게 됩니다.

immutableArray에서 forEach를 했을때 input 인자로 들어가는 Type은 Int이며, printParm Function의 parameter의 Type도 Int입니다.

2개의 Type이 다르면 에러가 발생합니다.

<br>

다음은 func가 없이 Clouser만 사용해서 같은 결과가 나오게 만들었습니다.

```swift
//func가 없이 클로져만 사용해서
let immutableArray = [1, 2, 3, 4]

immutableArray.forEach {num in
    print(num, terminator: " ") // 1 2 3 4
}

// 축약, forEach를 보고 컴파일러가 예측이 가능합니다.
immutableArray.forEach {
    print($0, terminator: " ") // 1 2 3 4
}

// Same
[1, 2, 3, 4].forEach {
    print($0, termainator: " ")	// 1 2 3 4
}
```



<br>

<br>

#### map

> map은 Collection의 컨터이너 내부의 기존데이터를 변형(transferm)하여 새로운 컨테이너를 생성합니다.
>
> Sequence의 elements에 지정된 closure를 Mapping한 결과가 들어 있는 collection을 반환합니다.
>
> 모든 요소에 하나하나 같은 조건을 대입해서 변현된 데이터를 새로운 컨테이너에 담는것입니다.

```swift
func map<T>(_ transform: (String) throws -> T) rethrows -> [T]

names.map { (String) -> T in
    code
}
```

.map의 다양한 활용 방법입니다.

```swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

names.map {
  $0 + "'s name"
}
```

names.map의 return값은

["Chris's name", "Alex's name", "Ewa's name", "Barry's name", "Daniella's name"] 입니다.

map의 특징은 Input인자로 전달될때 Array를 벗겨서 값의 Type으로 전달한뒤에 return될때는 다시 Array로 묶어서 반환합니다.

```swift
// 2를 10개 가지고 있는 Array
let intArr = Array<Int>(repeating: 2, count: 10)
// [2, 2, 2, 2, 2, 2, 2, 2, 2, 2]

// .enumerated()는 Array의 index와 key값을 반환합니다.
let result2 = intArr.enumerated().map { (offset: Int, element: Int) -> Int in
    offset + element
}
// [2, 3, 4, 5, 6, 7, 8, 9, 10]

// 축약
let result2 = intArr.enumerated().map {
  return $0 + $1
}
// [2, 3, 4, 5, 6, 7, 8, 9, 10]

//다른방식의 사용 (여긴 축약되어 있지만 return의 type이 String입니다.)
let result1 = intArr.enumerated().map {
  return "결과는 \($0 + $1) 입니다."
}
```

배열이 이중 배열일때 입니다.

```swift
let names2: [Any] = [[1, 2], 3, 4, [5], [6, 7, 8]]

names2.map { (num: Any) -> Any in
    num
}
// [[1, 2], 3, 4, [5], [6, 7, 8]]

names2.map {
    print($0, terminator: " ")
}
// [1, 2] 3 4 [5] [6, 7, 8]
// return [(), (), (), (), ()]
```

map의 input으로 전달될때는 Array를 1겹을 해제해서 전달합니다.

그래서 들어온 값을 출력하면 `[1, 2] 3 4 [5][6, 7, 8]`와 같은 결과가 나옵니다.

그리고 return을 할때 다시 Array로 만들어서 반환하기 때문에 `[[1, 2], 3, 4, [5], [6, 7, 8]]` 가 나옵니다.



<br>

<br>

#### filter

> 지정된 조건을 충족시키는 elements(요소)를 걸러서 새로운 컨테이너(Collection)으로 반환합니다.
>
> return은 Bool로 받으며, true면 값을 반환, false면 제거합니다.

```swift
func filter(_ isIncluded: (String) throws -> Bool) rethrows -> [String]

names.filter { (String) -> Bool in
    code
}
```

characters를 count해서 4개 이하의 값을 찾아내는 filter입니다.

```swift
let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let shortNames = cast.filter { $0.count < 5 }
print(shortNames)
// Prints "["Kim", "Karl"]"

cast[1].count // 6
```

$0. count의 characters가 5보다 크면 false로 값이 제거되고,

작으면 true로 filter가 된 값만 남습니다.

```swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

names.filter { (name) -> Bool in
  return name == "Chris"
}
// return값은 Chris

names.filter { (name) -> Bool in
  return name == "Tori"
}
// return값은 [], 모든 값이 false입니다.

// 축약
print(names.filter { $0 == "Alex" })
```



<br>

<br>

#### reduce

> Collection의 Element(요소)를 결합한 결과(컨테이너 내부의 콘텐츠를 하나로 통합)를 반환합니다.

```swift
func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Int) throws -> Result) rethrows -> Result

reduce(초기값, {결과값, input값} in 결과값 + input값)
```

reduce를 예제가 어떻게 동작하는지를 보려고 합니다.

```swift
let numbers = [1, 2, 3, 4]
let numberSum = numbers.reduce(0, { x, y in
    x + y
})
// numberSum == 10
```

초기값은 Int Type을 가지는 0값이고 x(result), y(input)을 가지고 x + y를 return해주는 reduce입니다. 이것을 흐름순으로 보면

1. 초기값인 0이 x로 들어갑니다
2. number[0]인 1이 y(input)로 들어갑니다.
3. 0 + 1의 값을 x로 전달합니다.
4. number[1]인 2가 y(input)로 들어갑니다.
5. x값인 1과 y값인 2를 더한값을 x로 전달합니다.
6. number[2]인 3가 y(input)로 들어갑니다.
7. x값 3과 y값 3을 더한 값을 x로 전달합니다.
8. number[3]인 4가 y(input)로 들어갑니다.
9. x값 6과 y과 4를 더한 값을 x로 전달합니다.
10. 더이상 들어올 값이 없습니다.
11. x값 10을 반환합니다.

이렇습니다.

여기서 중요한 몇가지는 reduce의 문법을 보면 초기값과, 결과값, 반환값, 재반환값이 전부 result로 되어있습니다. 이건 Type이 같다는 말로 이해해도 될것 같습니다.

또 reduce가 실행된 결과값이 다시 인자로 들어간다는 부분도 기억해야 될것 같습니다.



<br>

다음은 에러가 발생하는 경우입니다. 

```swift
(1...100).reduce(0) { (sum, next) in
  return sum + next
}

(1...100).reduce(0) { $0 + $1 }

(1...100).reduce(0) { (sum, next) in
  sum += next
}
```



<br>

Array[String]의 값의 합도 가능합니다.

input Type의 값이 다를경우 형변환을 해주면 사용이 가능합니다.

```swift
["1", "2", "3", "4"].reduce("") { (str, chr) in
  str + chr
}
// "1234"

["1", "2", "3", "4"].reduce("") { (str, int) in
    str + String(int)
}
// "1234"

["1", "2", "3C", "4A"].reduce("") { (str, int) in
    str + String(int)
}
// "123C4A
```



<br>

<br>

#### flatMap & compactMap

> flatMap는 중첩된 기능을 하나의 컬렉션으로 병합하는 기능과
>
> Element(요소) 중 옵셔널을 제거하는 기능이 있습니다.
>
> Swift 4.1이상부터는 옵셔널을 제거하는 기능은 compactMap으로 사용하도록 유도하고 있습니다.

```swift
func flatMap<SegmentOfResult>(_ transform: ([Int]) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence

.flatMap(transform: ([Int]) throws -> Sequence([Int]) throws -> Sequence)

.flatMap { ([Int]) -> Sequence in code }

.flatMap { $0 }
```

중첩된 기능을 하나의 컬렉션으로 병합하는 기능입니다.

```swift
let flatMapExamaple1 = [[1, 2, 3], [1, 5, 99], [1, 1]]
flatMapExamaple1.flatMap { $0 }
// [1, 2, 3, 1, 5, 99, 1, 1]
```

Element(요소) 중 Optional을 제거하는 기능입니다.

내부에 있는 `return self.map(tranform).filter { $0 != nil } .map { $0! }`을 통해서 진행이 됩니다.

```swift
let flatMapExamaple2 = [1, 5, nil, 9, 16, 100, nil, 7]

//아직 사용은 가능하지만 4.1 이상부터는 compactMap으로 사용하길 권장

flatMapExamaple2.flatMap { $0 }
//[1, 5, 9, 16, 100, 7]

flatMapExamaple2.compactMap { $0 }
//[1, 5, 9, 16, 100, 7]
```

위의 배열에서보면 들어온 배열을 .map을 tranform해주고 난다음 filter를 돌립니다. filter는 조건에 맞으면 true(보관), false(제거)를 하게 되는데 조건이 $0 != nil 이므로  nil값이 제거되게 됩니다.

그 뒤에 다시 남은 값들을 .map를 해서 언레핑을 하여 Optional을 제거 한 뒤에 새로운 배열을 만들어서 반환합니다.

<br>

중첩되어 있고 Optional이 같이 있을때 입니다.

```swift
let array: [[Int?]] = [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]

print(array.flatMap { $0 })
// [Optional(1), Optional(2), Optional(3), nil, Optional(5), Optional(6), nil, nil, nil]

print(array.flatMap { $0 }.flatMap { $0 })
print(array.flatMap { $0 }.compactMap { $0 })
// [1, 2, 3, 5, 6]
```

이해를 위해서 1번만 했을때를 먼저 보면

`print(array.flatMap { $0 })`

1. [[Int?]] = [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]에서 한겹 제거

2. [Int?] = [1, 2, 3], [nil, 5], [6, nil], [nil, nil] 

3. 옵셔녈이니까 

   [Optional(1),Optional( 2), Optional(3)]

   , [nil, Optional(5)]

   , [Optional(6), nil]

   , [nil, nil] 

4. flatMap의 기능인 중첩된 기능을 병합이 사용됨

5. [Optional(1), Optional(2), Optional(3), nil, Optional(5), Optional(6), nil, nil, nil]

<br>

옵셔널까지 제거해 주기 위해서는 2번사용해서 1번째로 배열을 벗겨주고 2번째로 옵셔널을 제거 하게 됩니다.

`print(array.flatMap { $0 }.compactMap { $0 })`

1. 위의 결과로 나온 [Optional(1), Optional(2), Optional(3), nil, Optional(5), Optional(6), nil, nil, nil]이 compactMap로 들어가게 됩니다.
2. 내부에서 .filter { $0 != nil }를 거쳐서 nil값이 제거가 되고,
3. 제거된 나머지 값들로 .map { $0! }을 거쳐서 언레핑이 된 값들이 나오게 됩니다.
4. [1, 2, 3, 4, 5, 6]
5. 지금은 `print(array.flatMap { $0 }.flatMap { $0 })` 도 같은 결과가 나옵니다.

<br>

절차를 반대로 하면 어떻게 될까?

```swift
let array: [[Int?]] = [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]


print(array.compactMap { $0 }.flatMap { $0 })
// [Optional(1), Optional(2), Optional(3), nil, Optional(5), Optional(6), nil, nil, nil]
```

1. [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]

2. 이중 배열 상태로 내부에 들어가서

   [ [Optional(1),Optional( 2), Optional(3)]

   , [nil, Optional(5)]

   , [Optional(6), nil]

   , [nil, nil] ]

3. filter { $0 != nil }를 만나서 배열이 1겹 없어지지만 배열인 상태로 nil값을 찾게 됩니다.

4. 그 상태가 끝나도 이중 배열 상태가 유지되고 (filter은 내부 값들을 처리하고 새로운 Collection에 넣습니다.)

5. 이중 배열 상태로 .map { $0! }을 만나 1겹을 벗고 언레핑을 하지만 배열상태라 언레핑이 되지 않고 입력한 값 그대로 반환하게 됩니다.

6. 그 값을 가지고 .flatMap { $0 }을 시작합니다.

7. 진행 절차는 위에서와 같습니다

8. [[Int?]] = [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]에서 한겹 제거

9. [Int?] = [1, 2, 3], [nil, 5], [6, nil], [nil, nil] 

10. 옵셔녈이니까 

    [Optional(1),Optional( 2), Optional(3)]

    , [nil, Optional(5)]

    , [Optional(6), nil]

    , [nil, nil] 

11. flatMap의 기능인 중첩된 기능을 병합이 사용됨

12. 결과값은 .flatMap { $0 }을 1번 해준것과 같은 [Optional(1), Optional(2), Optional(3), nil, Optional(5), Optional(6), nil, nil, nil]이 나오게 됩니다.



<br>

####  Chaining - 고차함수의 연결

위와 같이 2개 또는 다수의 고차함수를 연결해서 사용하는 것을 Chaining이라고 합니다.

```swift
let immutableArray4 = [1, 2, 3, 4]

print(immutableArray4.enumerated()
    .map {(offset, element) -> Int in
        return offset * element     // [0, 2, 6, 12]
    }.filter { (element) -> Bool in
        return element & 1 == 0     // [2, 6, 12]
    }.reduce(0) {(sum, nextElement) -> Int in
        return sum + nextElement    // 20
})
```

고차함수들은 체인처럼 연결해서 사용할 수 있습니다.

`[1, 2, 3, 4]`  배열이 enumerated()를 만나서 index와 Value로 나눠지게 되고

.map은 조건에 맞게 변형된 데이터를 새로운 배열에 담는것을 말하기 때문에 정해진 규칙인 배열의 index와 Value의 값을 곱해준다 실행하고 변형된 데이터 `[0*1, 2*1, 3 * 2 , 4 * 3]` 를 새로운 컨테이너(배열)에 담아 반환하게 됩니다.

그다음 반환된 값 [ 0, 2, 6, 12]가 .filter에 들어게됩니다. filter는 입력된 값들을 조건에 맞는지를 확인해서 True면 값을 남겨두고, fasle면 값을 삭제시키게 됩니다.

조건인 `element & 1 == 0` 은 입력된 Int값의 2진수를 1로 and계산된 결과값이 0이면 True가 되는 조건입니다. 그래서 짝수 `[2, 6, 12]` 만 남게되고 결과값을 새로운 컨테이너(배열)에 담아서 반환하게됩니다.

반환된 값 [2, 6, 12]는 .reduce에 들어가게 됩니다. .reduce는 초기값부터 시작해서 컨테이너의 마지막 값까지 정해진 규칙에 실행한 뒤에 반환하게 됩니다. map과의 차이점은 컨테이너의 값이 들어와서 규칙이 실행된 결과값들을 가지고 있게 되고 그 결과값을 다시 규칙에 사용하게 됩니다.

그래서 초기값 0과 배열의 첫번째 값인 2가 들어와서 더해지게 되고 그 결과값 2와 배열의 두번째 값은 6이 더해지게 되고 그 결과값인 8이 배열의 마지막값은 12와 더해지게 되어 20을 반환하게 됩니다. 

여기서 reduce는 값을 반환할때 map, filter와 다르게 Collercion으로 감싸서 반환하지 않습니다. 그래서 그냥 Int값이 반환되게 됩니다.



<br>

<br>

#### 고차함수 정리 (여기에 있는)





| Height-order Function | Body | Return                         |
| --------------------- | ---- | ------------------------------ |
| .forEach              |      | 반환값이 없는 형태             |
| .map                  |      | 변경된 새로운 컬렉션           |
| .filter               |      | 조건을 만족하는 새로운 컬렉션  |
| .reduce               |      | 요소들이 결합된 단 하나의 타입 |
| .flatMap              |      |                                |
| .compactMap           |      |                                |

















함수로도 만들어 보고 고차 함수로도 만들어 봐서 정리

#### Shorthand Argument Names 

```
map : [T] -> [U]
filter : [T] -> [T]
reduce : [T] -> U
```



#### map vs compactMap (4.1 ver 이후)

map는 nil값을 허용합니다.

flatMap, compactMap는 nil을 허용하지 않습니다.





```swift
let array: [[Int?]] = [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]
 
let m1 = array.map({ $0 })	// [1, 2, 3], [nil, 5]
let m2 = array.map({ $0.map({ $0 }) }) // [1, 2, 3], [nil, 5] -> 1, 2, 3, nil, 5
let m3 = array.map({ $0.flatMap({ $0 }) }) // [1, 2, 3], [nil, 5] -> 1,2,3,nil,5
let f1 = array.flatMap({ $0 }) // 배열을 조인하는 대신에 nil은 남아 있습니다.
let f2 = array.flatMap({ $0.map({ $0 }) })
//$0 -> [1, 2, 3,] [nil,5] [6, nil], [nil, nil]
//input값은(map이 적용되서) 1  ,   2 , 3이고 return은 배열 [1, 2, 3]
// 나온 배열들이 joinde


let f3 = array.flatMap({ $0.flatMap({ $0 }) }) // 마지막은 compatMap으로 받는거와 같습니다.

// 플랫맵에 들어오는게 배열인지 옵셔널인지 따라서 달라집니다. 결과가
```







```swift
let aLabel = view.subviews.flatMap({ $0 as? UILabel }).first

$0로 subviews 타입이 들어와서
as? UILabel 타입 비교를 하고
옵셔널을 벗길수 있다.
그러고 다시 .first에서 옵셔널이 붙어서

마지막 타입은 UILable 옵션널입니다.

그래서 이건 바인딩을 사용해서 해야 합니다. (바딩인이 되면 옵셔널이 사라집니다.)
```

그걸 for문으로

```swift
for object in objects {
  if let object = object as? T {
    return object
 }
}
```


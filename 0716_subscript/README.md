# Subscripts [첨자]

- Class, Struct, Enum에서 콜렉션, 순열, 리스트 등의 멤버 요소에 쉽게 접근하기 위한 방법중에 하나 입니다.
- 별도의 메소드를 구성하지 않고도 Index를 통해 어떤 값을 설정하고 검색이 가능합니다.

<br>

<br>

## Subscripts Syntax

- get과 set을 같이 사용하는 경우

```swift
class SomeClass {
    subscript(index: Int) -> Int {
        get {
            return 0
        }
        set {
            
        }
    }
}
```

- get만 있으면 생략이 가능합니다.

```swift
class SomeClass {
    subscript(index: Int) -> Int {
       return 0
    }
}
```

<br>

<br>

## Subscript에 값을 넣는 방법

### - Mutiplier

```swift
struct TimesTable {
    let mutiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(mutiplier: 3)
print("six times three is \(threeTimesTable[6])")
```

```swift
//result
threeTimesTable[6] // 3 * 6 = 18
```

1. `let threeTimesTable = TimesTable(mutiplier: 3)`
2. `threeTimesTable[6]` 가 입력되면 subscript 가 실행되고 그 결과가 return 됩니다.

<br>

- Int와 String을 다 사용하고 싶을때는 어떻게 해야 할까?

```swift
struct TimesTable {
    let mutiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
    subscript(index: String) -> Int {
        return multiplier * Int(index)!
    }
}
let threeTimesTable = TimesTable(mutiplier: 3)
```

- 아래와 같이 하나의 타입에 여러개의 Subscripts 정의하면 전달되는 index의 타입으로 구분하여 실행합니다.

  ```swift
  print("six times three is \(threeTimesTable[6])")
  
  subscript(index: Int) -> Int {
      return multiplier * index
  }
  ```

  ```swift
  print("five times seven is \(sixTimesTable["6"])")
  
  subscript(index: String) -> Int {
      return multiplier * Int(index)!
  }
  ```

<br>

<br>

### - Matrix

```swift
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        gird = Array(repeating: 0.0, count: row * columns)
    }

    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }

    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + columns]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.54
```

- `gird = Array(repeating: 0.0, count: row * columns)`는 repeating의 수가 count만큼 반복되는 배열을 만들게 됩니다.
- Assert 는 조건을 만족하지 않으면 앱을 죽일 수 있는 함수입니다.
- subscript를 실행하면서 입력되는 값이 0보다 작거나 rows, columns보다 작으면 false가 return 되는 `func indexIsValid()` 를 실행하게 됩니다.

1. `var matrix = Matrix(rows: 2, columns: 2)`
2. `matrix[0, 1] = 1.54` 를 실행하면 값을 넣어준거기 때문에 subscript의 set이 실행되면서 `grid[(row * columns) + column] = newValue` 를 실행합니다.
3. `grid[(row * columns) + column] = newValue` 는 다음과 같습니다.
   - row = 0, columns = 2, column = 1, newValue = 1.54
   - columns와 column을 주의해서 구분해야 합니다.
   - grid[1] = 1.45 와 같습니다.

```swift
print(matrix)
// Matrix(rows: 2, columns: 2, grid: [0.0, 1.54, 0.0, 0.0])
```

- Matrix이 가진 3가지 프로퍼티의 값이 출력됩니다.

<br>

- 그럼 get은 언제 실행 될까? 답은 아래와 같이 실행하면 됩니다.

```swift
print(matrix[0, 1])		// 1.54
```

<br>

<br>

- 여기서 알수 있는건 set은 값을 넣어 줄때 시작되고, get은 값을 꺼내올때 시작된다는 것을 알수 있습니다.
- subscript를 사용해서 다차원 행렬의 값을 넣어주고 꺼내올수 있습니다.


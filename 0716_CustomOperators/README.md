# Coustom Operator

- Operator도 커스텀이 가능합니다.
- Binary(이항연산자)와 같은 Infix(중위 연산자)와 Unary(단항) 연산자 같은 Prefix(전위 연산자)와 Postfix(후위 연산자)들을 커스텀 할수 있습니다.
-  Precedence group인 우선순위 그룹도 커스텀이 가능합니다.

<br>

<br>

## 중위 연산자 - Infix Operator

- A + B, A - B와 같이 중위에 사용되고 양쪽에 값이 있는 연산자를 말합니다.

  ```swift
  struct Vector2D {
      var x = 0.0, y = 0.0
  }
  
  extension Vector2D {
      sattic func + (left: Vector2D, right: Vector2D) -> Vector2D {
          return Vector2D(x: left.x + right.x, y: left.y + right.y)
      }
  }
  
  let voctor = Vector2D(x: 3.0, y: 1.0)
  let anthorVector = Vector2D(x: 2.0, y: 4.0)
  let combindeVector = vector + anotherVector
  print("combinedVector: ", combinedVector)
  ```

  - `let voctor = Vector2D(x: 3.0, y: 1.0)` 에서 let voctor는 x = 3.0, y = 1.0인 Vector2D의 객체를 가지고 있습니다.
  - let anthorVector = Vector2D(x: 2.0, y: 4.0) 에서 let anthorVector는 x = 2.0인, y = 4.0을 가지는 Vector2D의 객체를 가지고 있습니다.
  - 위에서 Infix operator(중위 연산자) +를 Vector2D + Vctor2D가 가능하게 커스텀 했기때문에 `vector + anotherVector` 의 연산이 가능하게 되었습니다.
  - 그 결과로 `let combindeVector` 는 3.0 + 2.0 인 5.0을 1.0 + 4.0인 5.0을 가져서 Vector2D(x: 5.0, y: 5.0)이 됩니다.

<br>

<br>

## 전위 연산자 - Prefix Operator

- 전위 연산자는 -A와 같이 앞쪽에 오는 연산자
- 중위 연산자를 커스텀하는것과는 다르게 `prefix`라고 명명해줘야 사용이 가능합니다.
- 기본적인 시스템에 존재하지 않는 연산자는 `operator`을 사용해서 추가 할수 있습니다.

<br>

```swift
struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
let alsoPositive = -negative
print("positive :", positive)
print("negative :", negative)
print("alsoPositive :", alsoPositive)
```

- `static prefix func - (vector: Vector2D) -> Vector2D () {}`
  - prefix를 명명해줘야합니다.
- let positive = Vector2D(x: 3.0, y: 4.0)는 X = 3.0, y= 4.0을 가지는 Vector2D의 인스턴스를 let positive에 할당합니다.
- 전위 연산자 - 는 Vector2D의 타입으로 들어오면 x와 y의 값을 -로 치환해서 반환하도록 되어있습니다.
- let negative = -positive 는 Vector2D(x: -3.0, y: -4.0) 가 됩니다.
- let alsoPositive = -negative 는 다시한번 치환해줘서 ector2D(x: 3.0, y: 4.0)가 됩니다.

<br>

<br>

## 후위연산자 - Postfix Operator

- A! 와 같이 뒤로와서 붙는 연산자입니다.

- 중위 연산자를 커스텀하는것과는 다르게 `postfix`라고 명명해줘야 사용이 가능합니다.

- 기본적인 시스템에 존재하지 않는 연산자는 `operator`을 사용해서 추가 할수 있습니다.

  ```swift
  postfix operator **
  
  extension Vector2D {
      static postfix func ** (vector: Vector2D) -> Vector2D {
          return Vector2D(x: vector.x * vector.x, y: vector.y * vector.y)
      }
  }
  
  let baseVector = Vector2D(x: 4, y: 6)
  let sqaredVector = baseVector**
  print(sqaredVector)
  ```

  - ** 연산자는 시스템에서 기본적으로 제공되지 않기 때문에 operator을 사용해서 operator에 추가해줬습니다.
  - **를 custom operator을 통해서 제곱(^) 계산되어 반환하도록 해줬습니다.
  - `let baseVector = Vector2D(x: 4, y: 6)` 를 해서 x = 4, y = 6을 가진 Vector2D의 인스턴스를 let baseVector에 담았습니다.
  - `let sqaredVector = baseVector**` 를 통해서 4^2, 6^2를 한 결과값을 담았습니다.
  - `print(sqaredVector)` 는 Vector2D(x: 16.0, y: 36.0) 입니다.

<br>

<br>

## 우선 순위 그룹 - Precedence group

- 시스템에 선언되어 있는 연산자는 우선순위가 그룹에 묶여서 정의 되어 있습니다.
- Swift standard Library Precedence Group

| 우선 순위 | 그룹이름                     | 연관성        | 샘플          |
| --------- | ---------------------------- | ------------- | ------------- |
| -         | Group Name                   | Associativity | Examples      |
| 1         | BitwiseShiftPrecedence       | none          | << >>         |
| 2         | MultiplicationPrecedence     | left          | * /           |
| 3         | AdditionPrecedence           | left          | - +           |
| 4         | RangeFormationPrecedence     | none          | ... ..<       |
| 5         | CastingPrecedence            | none          | is as as? as! |
| 6         | NilCoalescingPrecedence      | right         | ??            |
| 7         | ComparisonPrecendence        | none          | != < > >= ==  |
| 8         | LogicalConjunctionPrecedence | left          | &&            |
| 9         | LogicalDisjunctionPrecedence | left          | \|\|          |
| 10        | DefaultPrecedence            | none          |               |
| 11        | TernaryPrecedence            | right         | ? :           |
| 12        | AssignmentPrecedence         | right         | += = *= -= /= |

<br>

- 다음과 같은 예제가 있습니다.

```swift
struct Vector2D {
    var x = 0.0, y = 0.0

    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}

precedencegroup DotProductPrecedence {
    associativity: left
    lowerThan: MultiplicationPrecedence 
    higherThan: AdditionPrecedence  
}

infix operator •: DotProductPrecedence

extension Vector2D {
    static func • (lhs: Vector2D, rhs: Vector2D) -> Double {
        return lhs.x * rhs.x + lhs.y * rhs.y
    }
}
```

- 예제를 통해서 연산자의 우선순위를 커스텀 하는 방법을 알아보려고 합니다. 하나씩 뜯어보면 다음과 같습니다.

  ```swift
  struct Vector2D {
      var x = 0.0, y = 0.0
  
      static func + (left: Vector2D, right: Vector2D) -> Vector2D {
          return Vector2D(x: left.x + right.x, y: left.y + right.y)
      }
  }
  ```

  - struct를 사용해서 Vector2D를 정의해줬습니다.
  - 중위 연산자를 커스텀해서 들어오는 Vector2D 타입의 인스턴스의 x값들과 Y값들을 더한 값을 반환해줍니다.

  ```swift
  infix operator +-: AdditionPrecedence
  extension Vector2D {
      static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
          return Vector2D(x: left.x + right.x, y: left.y - right.y)
      }
  }
  ```

  - infix +- 연산자를 정의해줬습니다. 시스템에 존재하는 연산자가 아니기 때문에 operator을 사용해서 정의해 줬으며, 역시 같은 이유로 우선순위 그룹(Precedence Group)에 포함되어 있지 않아서 additionPrecedence(+ -)의 그룹에 넣어줬습니다.
  - 그리고 중위연산자(Infix)이기 때문에 연산자 커스텀시 명명해주지 않아도 됩니다.
  - 커스텀은 Vector2D 타입으로 들어온 인스턴스는 X끼리는 더하고 Y끼리는 뺀 값을 반환합니다.

  ```swift
  precedencegroup DotProductPrecedence {
      associativity: left
      lowerThan: MultiplicationPrecedence 
      higherThan: AdditionPrecedence  
  }
  ```

  - 새로운 Precedence group을 만드는 방법을 사용했습니다.
  - 그룹으로 DotProductPrecedence은 MultiplicationPrecedence 보다는 낮고 AdditionPrecedence 보다는 높으면서 left와 연관성이 있는 group이 됩니다.
  - lowerThan 보다는 아래 higherThan 보다는 높게 레벨이 정해집니다.

  ```swift
  infix operator •: DotProductPrecedence
  
  extension Vector2D {
      static func • (lhs: Vector2D, rhs: Vector2D) -> Double {
          return lhs.x * rhs.x + lhs.y * rhs.y
      }
  }
  ```

  - infix •는 시스템에 정의되어 있지 않기 때문에 operator을 사용해서 정의해줬으며 우선순위그룹(Precedence group)은 MultiplicationPrecedence 보다는 낮고 AdditionPrecedence 보다는 높은 DotProductPrecedence으로 정해줬습니다.
  - 그리고 Vector2D 타입으로 들어오는 값들에 대해서 X끼리 곱해주고 Y끼리 곱해준뒤 더한값을 반환합니다.

<br>

- 이제 실제로 값을 넣어서 확인해 보겠습니다.

  ```swift
  let vector = Vector2D(x: 3.0, y: 5.0)
  print(vector + vector • vector)
  ```

  - 위와 같이 실행하면 에러가 발생합니다.

  - `Binary operator '+' cannot be applied to operands of type 'Vector2D' and 'Double'`

  - 이진 연산자 '+'는 'Vector2D'및 'Double'유형의 피연산자에 적용 할 수 없습니다라는 에러 입니다.

  - 왜 에러가 발생할까?

  - 아까 위에서 만들어 준 연산자 •는 우선순위그룹에서 DotProductPrecedence를 따르고 있습니다. 해당 그룹은 MultiplicationPrecedence보다는 낮고 AdditionPrecedence보다는 높은 그룹입니다.

  - 그렇기 때문에 AdditionPrecedence 그룹인 연산자 + 보다 먼저 계산 하게됩니다. 그래서 vector • vector결과값은 Double 타입을 가지게 되고 예제에서는 vector + Double는 연산자 커스텀을 해주지 않았기 때문에 에러가 발생합니다.

  - 해결 방법으로는 ()를 사용해서 먼저 +를 계산하게 하면 됩니다.

    ```swift
    (vector + vector) • vector
    ```

  <br>

  ```swift
  vector • vector + 3.0
  ```

  - vector • vector이 우선순위그룹이 높기 때문에 먼저 계산이 되고 반환값이 Double 타입이기 때문에 정상계산이 됩니다.

  <br>

- 그렇다면 ()를 사용하지 않고 연산을 수행하게 할수는 없을까?

  ```swift
  vector +- vector • vector
  ```

  - 위의 구문을 실행하면 에러가 발생합니다.
  - 연산자 •는 AdditionPrecedence 보다는 높은 그룹입니다.
  - 연산자 +-는 AdditionPrecedence 그룹과 같습니다.
  - 그럼 vector • vector 먼저 실행이 되고 Double값을 반환합니다.
  - vector +- Double은 operator custom 해주지 않았기 때문에 에러가 발생합니다.
  - 그럼 반환값이 Vctor2D인 vector +- vector를 먼저 계산해야 하는데 ()를 사용하지 않고는 해결하고 싶습니다.
  - 방법은 간단합니다. 연산자 +-의 우선순위그룹(Precedence Group)을 AdditionPrecedence 그룹보다 높게 설정해주면 됩니다.
  - MultiplicationPrecedence or BitwiseShiftPrecedence 둘중 하나를 사용하면 됩니다.

<br>

<br>

- 이번 공부를 통해서 중위연산자(Infix), 전위연산자(Prefix), 후위연산자(Postfix)를 Custom 할수있다는걸 알았습니다.
- prefix와 postfix는 custom하기 위해서는 명명해줘야 한다는 것을 알았습니다.
- 연산자는 Precedence group이 있기때문에 custom해서 사용할때는 신경써서 정해줘야 한다는것을 알았습니다.






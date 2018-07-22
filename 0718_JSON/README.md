# JSON

- Javascript Object Notation - 자바스크립트 오브젝트의 표기법입니다.
- 프로그래밍 언어와 플랫폼 간 독립적이고 가벼워서 거의 표준으로 사용되고 있는 데이터 교환 형식입니다.
- 값들의 순서화된 리스트로 대부분의 언어들에서 Array, Vector, List 또는 Sequence로 구현됩니다.

<br>

<br>

## JSON Object 표기법

![object.gif](./img/object.gif)

- object는 name/value 쌍들의 비순서화된 SET입니다. 
- `{ }` 중괄호로 시작과 끝을 표현합니다.
- Name 뒤에 콜런(:)을 붙이고 콤마(,)로 name/Value 쌍들을 구분합니다.

```json
{	// Object 시작
    "message": "success",
    "people": [
        {
            "craft": "ISS",
            "name": "Oleg Artemyev"
        }
    ]
}	// object 끝
```

<br>

<br>

## JSON Array 표기법

![array](./img/array.gif)

- 값들의 순서화된 Collection입니다.
- `[ ]` 대괄호로 시작과 끝을 표현합니다.

```json
{
    "message": "success",
    "people": [		// Array 시작
        {
            "craft": "ISS",
            "name": "Oleg Artemyev"
        }
    ]				// Array 끝
}
```

<br>

<br>

## JSON Value 표기법

![value](./img/value.gif)

- `" "` 큰 따옴표안에 string, number, true, false, null, object, array 등의 구조를 넣을 수있습니다.

```json
{
    "someNumber" : 1,
    "someString" : "Hello",
    "someArray"  : [1, 2, 3, 4],
    "someDict"   : {
      "someBool" : true
    }
 }
```

<br>

<br>

<br>

<br>

## Data로 만들거나 JSON Object로 변환하는 방법

### OutputStream을 사용해서 JSONObject 만들기

- JSON은 최상단 오브젝트가 딕셔너리나 배열이여야 한다는 걸 기억해야합니다.

```swift
func writeJSONObjectToOutputStream() {
    let jsonObject = ["hello": "world", "foo": "bar", "iOS": "Swift"]
    
    guard JSONSerialization.isValidJSONObject(jsonObject) else { return }

    let jsonFilePath = "myJsonFile.json"
    let outputJSON = OutputStream(toFileAtPath: jsonFilePath, append: false)!
    outputJSON.open() 
    _ = JSONSerialization.writeJSONObject( 
        jsonObject,    
        to: outputJSON,
        options: [.prettyPrinted, .sortedKeys],
        error: nil  
    )
    outputJSON.close()  

    do { 
        let jsonString = try String(contentsOfFile: jsonFilePath)
        print(jsonString)
    } catch {
        print(error.localizedDescription)
    }
}
```

- 한줄씩 보면 다음과 같습니다.

  ```swift
  let jsonObject = ["hello": "world", "foo": "bar", "iOS": "Swift"]
  ```

  - 딕셔너리를 만들었습니다.

  ```swift
  JSONSerialization.isValidJSONObject(jsonObject)
  ```

  - `.isValidJSONObject` 는 jsonObject로 변환이 가능한지를 확인해서 true, false를 반환합니다.

  ```swift
  let jsonFilePath = "myJsonFile.json"
  let outputJSON = OutputStream(toFileAtPath: jsonFilePath, append: false)!
  outputJSON.open() 
  _ = JSONSerialization.writeJSONObject( 
      jsonObject,    
      to: outputJSON,
      options: [.prettyPrinted, .sortedKeys],
      error: nil  
  )
  outputJSON.close() 
  ```

  - OutputStream은 파일로 저장할때 사용하는 클래스입니다.

  - `let outputJSON = OutputStream(toFileAtPath: jsonFilePath, append: false)!` 를 해서 파일을 생성합니다.

  - 지금은 파일만 생성된 상태입니다.

  - 이제 파일에 데이터를 써야 합니다.

  - `outputJSON.open() ` 파일 열기

  - .writeJSONObject를 사용해서 파일에 jsonobject를 쓸수 있습니다.

    ```swift
    //.writeJSONObject
    JSONSerialization.writeJSONObject(
        obj: Any,	// 넣고 싶은 오브젝트
        to: OutputStream,	// 넣고 싶은 outputStream
        options: JSONSerialization.WritingOptions, // 기록할때 옵션 
        error: NSErrorPointer	// 에러처리
    )
    ```

  - `outputJSON.close() ` 파일에 기록이 끝난다음에는 꼭 파일을 닫아줘야 합니다.

  ```swift
  do { 
      let jsonString = try String(contentsOfFile: jsonFilePath)
      print(jsonString)
  } catch {
      print(error.localizedDescription)
  }
  }
  ```

  - do - try = catch를 사용해서 파일에 저장이 잘 되었는지를 확인 할수 있습니다.
  - `let jsonString = try String(contentsOfFile: jsonFilePath)` 로 파일을 열어 내용을 가져올수 있습니다.

<br>

<br>

### Inputstream을 사용해서 JSONObject로 변환하기

- OutputStream을 사용해서 만들어준 파일을 불러와서 다시 jsonobject로 변환하는 과정입니다.
- defer는 스코프가 종료될때 무조건 종료되어야 하는 코드를 넣어 놓을 수 있습니다.

```swift
private func jsonObjectWithInputStream() {
  let jsonFilePath = "myJsonFile.json"      
  let inputStream = InputStream(fileAtPath: jsonFilePath)!  
  inputStream.open()
  defer { inputStream.close() }
  
  guard inputStream.hasBytesAvailable else { return }   // 가용성 확인
    
  do {
    let jsonObject = try JSONSerialization.jsonObject(with: inputStream)    
    print(jsonObject)
  } catch {
    print(error.localizedDescription)
  }
}

jsonObjectWithInputStream()
```

<br>

<br>

### JSON Object를 사용해서 JSON 만들기

```swift
private func dataWithJSONObject() {
    let jsonObject1: [String: Any] = [
        "someNumber" : 1,
        "someString" : "Hello",
        "someArray"  : [1, 2, 3, 4],
        "someDict"   : [
            "someBool" : true
        ]
    ]

    guard JSONSerialization.isValidJSONObject(jsonObject1)
    else { return }

    do {
        let encoded = try JSONSerialization.data(withJSONObject: jsonObject1)
        let decoded = try JSONSerialization.jsonObject(with: encoded)
        if let jsonDict = decoded as? [String: Any] {
            print(jsonDict)
        }
    } catch {
        print(error.localizedDescription)
    }
}
```

- 한줄씩 보면 다음과 같습니다.

  ```swift
  let jsonObject1: [String: Any] = [
          "someNumber" : 1,
          "someString" : "Hello",
          "someArray"  : [1, 2, 3, 4],
          "someDict"   : [
              "someBool" : true
          ]
      ]
  ```

  - jsonObject로 만들어 줄수 있는 형식을 사용했습니다.
  - JSON은 최상위 계층으로 딕셔너리와 배열이 올수 있습니다.

  ```swift
  guard JSONSerialization.isValidJSONObject(jsonObject1)
      else { return }
  ```

  - 만들어준 변수가 JSONObject로 만들어 줄수 있는지를 확인합니다.

  ```swift
  let encoded = try JSONSerialization.data(withJSONObject: jsonObject1)
  ```

  - JSonSerialization을 사용해서 JSONObject를 데이터로 변환해 줬습니다.
  - 옵션을 넣어서 정렬되게 하거나 개행을 넣을수 있습니다.

  ```swift
  let decoded = try JSONSerialization.jsonObject(with: encoded)
  ```

  - 변환한 데이터를 jsonObject로 변환했습니다.

  ```swift
  if let jsonDict = decoded as? [String: Any]
  ```

  - decoded 의 타입이 Any이기 때문에 String : Any로 타입캐스팅을 합니다.

  ```swift
  print(jsonDict)
  ```

  - 그 결과를 출력합니다.

- `JSONSerialization.data`를 사용해서 json object 형식을 데이터로 만들수 있습니다.

- `JSONSerialization.jsonObject` 사용해서 데이터를 json object로 변환할수 있습니다.

<br>

<br>

### 멀티라인 스트링을 사용해서 JSON Object 만들기

- swift의 멀티라인 스트링을 사용해서 JSON 형식을 만들어주고 data로 변환한 뒤에 다시 꺼내오는 과정입니다.

```swift
private func jsonObjectWithData() {
  let jsonString =  """
  {
    "someNumber" : 1,
    "someString" : "Hello",
    "someArray"  : [1, 2, 3, 4],
    "someDict"   : {
      "someBool" : true
    }
  }
  """
    
  let jsonData = jsonString.data(using: .utf8)! 
  do {
    let foundationObject = try JSONSerialization.jsonObject(with: jsonData)    
    if let jsonDict = foundationObject as? [String: Any] {                     
      print(jsonDict)
    }
  } catch {
    print(error.localizedDescription)                                       
  }
}

jsonObjectWithData()
```

- 멀티라인 스트링을 사용해서 let jsonString을 만들어 줍니다.
- `  let jsonData = jsonString.data(using: .utf8)! ` 을 사용해서 data로 변환합니다.
- `JSONSerialization.jsonObject(with: jsonData)` 를 사용해서 Jsonobject로 변환합니다.

<br>

<br>
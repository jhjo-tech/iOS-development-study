# Parsing

- 일련의 문자열을 의미있는 토큰으로 분해하고 이들로 이루어진 파스트리를 만드는 과정입니다.
- JSON을 사용해서 Parsing을 하는 과정을 공부해봤습니다.

<br>

## 전체 코드 보기

```swift
let position = "http://api.open-notify.org/iss-now.json"
let apiURL = URL(string: position)!

let dataTask = URLSession.shared.dataTask(with: apiURL) {
    (data, response, error) in

    guard error == nil else { return print("error")}
    guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
        print("status error")
        return
    }
    
    guard let data = data else { return print("Parsing error")}
    guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as! [String : Any]
    else { return print("object error")}

    guard (jsonObject["message"] as? String) == "success",
    let timestamp = jsonObject["timestamp"] as? Double,
    let issPositon = jsonObject["iss_position"] as? [String : String]
    else { return print("Parsing error")}

    guard let latitude = issPositon["latitude"],
    let longitude = issPositon["longitude"]
    else {return}


    let changeDate = Date(timeIntervalSince1970: timestamp)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    let stringDate = dateFormatter.string(from: changeDate)

    print("현재 시간 \(stringDate) 우주 왕복선의 위치는 latitude: \(latitude), longitude:\(longitude) 입니다.")
}

dataTask.resume()
```

- `http://api.open-notify.org/iss-now.json` API(Application Programming Interface)를 사용해서 데터이를 Parsing하는 과정입니다.
- URLSession.shared.dataTask를 사용해서 data, response, error을 받습니다.
- error과 response를 확인하고 들어오는 data를 jsonObject로 변환합니다.
- 변환된 jsonObject를 사용할 데이터 형식에 맞게 타입캐스트을 사용해서 변환해줍니다.
- 변환이 끝난 값들은 사용하고자 하는 목적에 맞게 사용하면 됩니다.
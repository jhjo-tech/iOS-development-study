# UserDefault

- iOS에서 데이터를 파일에 저장하기 위해 사용하는 대표적인 클래스입니다.
- 간단한 정보를 저장하고 불러올 때 사용하며 내부적으로 pList파일로 저장합니다.
- UserDefault는 파일로 저장장치에 저장합니다.



## Basic

- `set` 을 사용해서 값을 넣어주고 forKey를 지정합니다.
- 해당 값에 해당하는 type을 사용한뒤에 forKey를 사용해서 값을 불러옵니다.

```swift
let userDefault = UserDefaults.standard

userDefault.set(10, forKey: "IntKey")
userDefault.integer(forKye: "IntKey")	// 10

userDefault.set(3.14, forKey: "DoubleKey")
userDefault.double(forKye: "DoubleKey")	// 3.14

//string과 object의 차이는 return이 Any인지 String인지
userDefault.set("String", forkey: "StringKey")
userDefault.object(forKey: "StringKey")	// "String"
userDefault.string(forKey: "StringKey")	// String

userDefault.set(true, forKey: "Boolkey")
userDefault.bool(forKey: "Boolkey")
```

```swift
// 내부에 데이터가 뭐있는지 알고 싶을때
print(userDefault2.dictionaryRepresentation())

// Key값을 알고 싶을때
print(Array(UserDefaults.standard.dictionaryRepresentation().keys))

// Value를 알고 싶을때
print(Array(UserDefaults.standard.dictionaryRepresentation().values))
```

<br>

<br>

## Example

```swift
import UIKit

final class ViewController: UIViewController {
  
  struct Key {
    static let today = "kTODAY"
    static let alertOn = "kAlertOn"
  }

  @IBOutlet private weak var datePicker: UIDatePicker!
  @IBOutlet private weak var alertSwitch: UISwitch!
  
  @IBAction func saveData(_ button: UIButton) {
    let userDefaults = UserDefaults.standard
    userDefaults.set(datePicker.date, forKey: Key.today)
    userDefaults.set(alertSwitch.isOn, forKey: Key.alertOn)
  }
  
  @IBAction func loadData(_ button: UIButton) {
    let userDefaults = UserDefaults.standard

    guard let today = userDefaults.object(forKey: Key.today) as? Date else { return }
    
    datePicker.date = today
    alertSwitch.setOn(userDefaults.bool(forKey: Key.alertOn), animated: true)
    
  }
}
```

변수로 받아서 해당 객체에 대한 속성을 변경해 주기 위해서 IBOutlet을 사용했습니다.

<br>

```swift
@IBAction func saveData(_ button: UIButton) {
    let userDefaults = UserDefaults.standard
    userDefaults.set(datePicker.date, forKey: Key.today)
    userDefaults.set(alertSwitch.isOn, forKey: Key.alertOn)
  }
```

`datepicker` 의 현재값을 받아서 forKey값으로 `"kTODAY"` 를 지정했습니다.

`alertSwitch.isOn`으로 버튼의 현재값(bool값)을 받아서 저장하고 forKey값으로 `"kAlertOn"` 를 줬습니다.

<br>

<br>

```swift
  @IBAction func loadData(_ button: UIButton) {
    let userDefaults = UserDefaults.standard

    guard let today = userDefaults.object(forKey: Key.today) as? Date else { return }
    
    datePicker.date = today
    alertSwitch.setOn(userDefaults.bool(forKey: Key.alertOn), animated: true)
    
  }
```

@IBAction과 연결된 버튼을 누르면 동작하는 함수를 만들어 줬습니다.

버튼을 누르면 우선 Early exit 인 guard문이 실행 됩니다.

조건은 `userDefaults.object(forKey: Key.today)` 를 Data로 다운캐스팅(as?)해서 성공하면 다음문장을 실행하고 nil값이 들어오면 return을 실행하게 됩니다.

다운캐스팅을 해준 이유는 `.object` 의 return이 **Any?(Optional Any) Type**이기 때문입니다.

저장된 값이 있으면 정상적으로 다운캐스팅되서 optional이 벗겨진 값이 datePicker.date로 할당되게 되고

`alertSwitch.setOn(userDefaults.bool(forKey: Key.alertOn), animated: true)` 가 실행되서버튼이 이전상태로 돌아가게 됩니다.

<br>

이와같이 값을 저장한 뒤에 다시 꺼내오는 방법을 사용해서 이전데이터를 다시 돌려주는 것과 같은 상황을 표현할수 있습니다.

<br>

<br>


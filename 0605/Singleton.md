# Singleton

- 특정 클래스의 인스턴스에 접근할 때 항상 동일한 인스턴스만을 반환하도록 하는 설계패턴입니다.
- 한 번 생선된 이후에는 프로그램이 종료 될때까지 항상 메모리에 상주합니다. (메모리의 데이터 영역에 생성)
- 어플리케이션에서 유일하게 하나만 필요한 객체(UIApplication, AppDelegate등)에 사용합니다.

<br>

<br>

<br>

## Basic 

Singleton은 자기자신을 다시한번 만들어서 내부 속성으로 저장하는 것을 말합니다.

static은 상속이 되지 않고 재정의를 할수 없습니다. 이렇게 해주면 타입전체가 싱글톤이라는 하나의 객체를 유지 할수 있게 됨으로 다른곳에서 변경이 불가능 하게 됩니다.

그리고 초기화를 private로 지정해줘서 인스턴스를 여러개 만들지 못하게하고 그렇기 때문에 인스턴스를 여러개 만들어도 같은 값을 유지하게 해줍니다.

```swift
class PrivateSingleton {
    static let shared = PricatedSingleton()
    private init() {}
    var x = 1
}

// private는 현재 class scope에서만 사용이 가능하기 때문에 에러 발생
let uniqueSingleton = PrivateSingleton.init()

let let uniqueSingleton = PrivateSingleton.shared
uniqueSingleton.x			// 1

uniqueSingleton.x = 20
uniqueSingleton.x			// 20
```

<br>

<br>

## 실제로 사용해보면

```swift
import Foundation
import UIKit


final class User {
  static let shared = User()
  private init() {}
  var friends: [Friends] = []
  var blocks: [Friends] = []
}

final class Friends {
  let name: String
  init(name: String) { self.name = name }
}

final class FriendListViewController: UIViewController {
  func addFriend() {
    let 원빈 = Friends(name: "원빈")
    let 현빈 = Friends(name: "현빈")
    User.shared.friends.append(원빈)
    User.shared.friends.append(현빈)
  }
}

final class BlockListViewController: UIViewController {
  func blockFriend() {
    let friend = Friends(name: "현빈")
    if let index = User.shared.friends.index(where: { $0.name == friend.name }) {
      User.shared.friends.remove(at: index)
    }
    if !User.shared.blocks.contains(where: { $0.name == friend.name }) {
      User.shared.blocks.append(friend)
    }
  }
}

let friendListVC = FriendListViewController()
friendListVC.addFriend()
User.shared.friends

let blockListVC = BlockListViewController()
blockListVC.blockFriend()
User.shared.friends
User.shared.blocks
```



Singleton은 한번 생성되면 프로그램이 종료될때까지 메모리에 상주하기 때문에 인스턴스를 여러개 만들어도 같은 값을 가지게 할수 있습니다.

이 코드는 "현빈"과 "원빈"을 friends라는 배열에 넣어주고 "현빈"이 있으면 제거 하면서 blocks에 넣어줍니다.

이전에는 class에서 변수를 만들어주면 class 내에서만 접근이 가능했었기 때문에 다른 class에서 해당 변수의 값을 같이 사용하려면 번거로운 작업들을 했었습니다. 그런 작업들을 한번 생성되면 종료시까지 메모리에 상주하는 Singleton을 만들어줘서 보다 쉽게 사용할수 있습니다.

1. 우선 Singleton을 만들어줍니다.

````swift
final class User {
  static let shared = User()
  private init() {}
  var friends: [Friends] = []
  var blocks: [Friends] = []
}
````

이렇게 만들어 놓은 Singleton은 전역변수가 되기 때문에 `User.shared.friedns` 또는 ` User.shared.blocks ` 를 사용해서 어디에서든 접근이 가능합니다.

<br>

2. Singleton을 사용해서 실제 동작할 class들을 만들어 줍니다.

```swift
final class Friends {
  let name: String
  init(name: String) { self.name = name }
}

final class FriendListViewController: UIViewController {
  func addFriend() {
    let 원빈 = Friends(name: "원빈")
    let 현빈 = Friends(name: "현빈")
    User.shared.friends.append(원빈)	// singleton Array에 값을 추가함
    User.shared.friends.append(현빈)	// singleton Array에 값을 추가함
  }
}

final class BlockListViewController: UIViewController {
  func blockFriend() {
    let friend = Friends(name: "현빈")
    if let index = User.shared.friends.index(where: { $0.name == friend.name }) {
      User.shared.friends.remove(at: index)
    }
    if !User.shared.blocks.contains(where: { $0.name == friend.name }) {
      User.shared.blocks.append(friend)
    }
  }
}
```

<br>

3. 만들어준 class를 인스턴스화해서 사용합니다. 인스턴스화를 해도 Singleton의 값은 초기화가 되지 않습니다. 

```swift
let friendListVC = FriendListViewController()
friendListVC.addFriend()
User.shared.friends				// ["원빈", "현빈"]

let blockListVC = BlockListViewController()
blockListVC.blockFriend()
User.shared.friends				// ["원빈"]
User.shared.blocks				// ["현빈"]
```



<br>

<br>

## 주의사항

Singleton은 프로그램이 종료되기까지 항상 메모리에 상주하기 때문에 너무 잦은 사용은 메모리에 부담을 줄수 있습니다.

<br>

<br>

## iOS에서 Singleton

```swift
let screen = UIScreen.main
// 파일을 저장하는 클래스입니다
let userDefaults = UserDefaults.standard
let application = UIApplication.shared
let fileManager = FileManager.default
let notification = NotificationCenter.default
```

<br>

<br>
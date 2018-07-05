# Notification

- A notification dispatch mechanism that enables the broadcast of information to registered observers.
- 등록 된 observers에게 정보를 브로드캐스팅(방송) 할 수있게하는 알림 발송 메커니즘입니다.
- NotificationCenter를 통해서 observer를 걸어놓거나 post(커스텀 알림을 보내는)를 할수 있습니다.

<br>

<br>

## NotificationCenter

```swift
open class NotificationCenter : NSObject {
	open class var `default`: NotificationCenter { get }
}
```

- `NotificationCenter` 는 Singleton pattern으로 여러번 생성되어도 객체가 하나입니다.

  <br>

```swift
	open func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?)

	@available(iOS 4.0, *)
	open func addObserver(forName name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Swift.Void) -> NSObjectProtocol
```

- addObserver를 사용해서 원하는 위치 및 상황에 알림센터 옵져버를 설치 할수 있습니다.

  <br>

```swift
open func post(_ notification: Notification)

open func post(name aName: NSNotification.Name, object anObject: Any?)

open func post(name aName: NSNotification.Name, object anObject: Any?,
               userInfo aUserInfo: [AnyHashable : Any]? = nil)
```

- post를 사용해서 커스텀한 알림을 Observer에게 보낼수 있습니다.

- `NSNotification.Name` 을 시스템에 있는 종류로 주면 별도의 Post를 사용하지 않아도 발송이 됩니다.

  <br>

```swift
open func removeObserver(_ observer: Any)

open func removeObserver(_ observer: Any,
                         name aName: NSNotification.Name?,
                         object anObject: Any?)
```

- removeObserver를 사용해서 설치된 Observer를 제거 할수 있습니다.

<br>

<br>

## NotificationCenter addObserver

- Observer를 설치하면 노티를 발송해야 하는 상황이 발생하였을때, 받아서 볼수 있습니다.
- `NSNotification.Name` 을 시스템에 있는 종류를 주면 발송을 하는 Post가 없어도 addObserver만으로 발송이 됩니다.
- 예를들어 키보드가 올라왔을때 키보드의 정보나 화면 방향이 변경되었을때와 같은 상황에 동작하도록 Observer를 설치할수 있습니다.

```swift
import UIKit

class ViewController: UIViewController {
    let notiCenter = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        notiCenter.addObserver(self, selector: #selector(deivce(_:)),
                               name: NSNotification.Name.UIDeviceOrientationDidChange,
                               object: nil)
    }

    @objc func deivce(_ noti: Notification) {
        print(noti)
        print("device")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("NotificationCenter end")
    }
}
```

1. ViewController이 앱에서 구동되면서 viewDidLoad()가 1번 실행됩니다.
2. viewDidLoad()의 내부에 화면의 방향이 변경되면 노티를 Post하는 NSNotification.Name.UIDeviceOrientationDidChange Observer를 설치했습니다.
3. 그 Observer는 화면이 변경되면 @objc func deivce(_:) 를 실행하게 되면서 "device" 가 출력됩니다.
4. 주의 할점은 NotificationCenter.defaule는 싱글턴패턴이기 때문에 사용이 완료 되었을때 removeObserver를 해주지 않으면 앱이 종료 될때까지 메모리에 남아 있게 됩니다.
5. 그래서 viewDidLoad()에 설치한 Observer를 ViewController이 deinit할때 removeObserver하게 됩니다. (self)를 사용하면 ViewController에 있는 모든 Observer가 제거 되게 되며, (Notification.Name) 을 적으면 적용되는 Observer만 제거하게 됩니다.

<br>

- 위와같이 @objc를 만들어주는 방법 외에도 아래와 같이 사용도 가능합니다. 반환타입이 NSObjectProtocol임을 기억하고 주의해서 사용해야 합니다.

```swift
notiCenter.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: .main) { (noti) in                                                                                      print("UIKeyboardDidShow") }
```

<br>

<br>

## Delegate와 Notification은 뭐가 다른 걸까

- Delegate와 Notification은 정보를 다른 곳(다른 class)에 전달을 할수 있다는 공통점이 있지만 Delegate는 .self를 선언해준 class에서만 사용이 가능 하지만 NotificationCenter는 싱글턴패턴이기 때문에 Observer를 등록한 모든곳에 정보를 전달하게 됩니다.
- view가 많아지는 상황이 발생한다면 정확하게 어디서 전달해서 어디로 도착하는지를 알아보기 힘들어지는 상황이 발생할수 있습니다.
- 델리게이트는 선언한 곳에서만 사용한다고 생각하고 notification은 확성기같이 Observer를 등록한 곳에서 다 받아 본다고 생각하면 이해가 쉬울것 같습니다.

<br>

<br>

## 상황에 따른 NotificationCenter addObserver와 removeObserver

- view가 처음 불어와지는 viewdidLoad()가 아닌 다른곳에 만들었을때는 언제 제거를 해줘야 할까?

```swift
import UIKit

class ViewController: UIViewController {
    let notiCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
	notiCenter.addObserver(self, selector: #selector(deivce(_:)),
                           name: NSNotification.Name.UIDeviceOrientationDidChange
                           object: nil)        
    }
    
@objc func deivce(_ noti: Notification) {
	print(noti)
	print("device")
	}
    
	deinit {	NotificationCenter.default.removeObserver(self)
	print("NotificationCenter end")
    }
}
```

- 예를들어 viewWillApperar에 observer를 설치해주면 탭바와 같이 이동할때 viewWillAppear 메소드는 동작을 하는데 deinit은 안되는 상황에서는 addObserver가 중복되서 만들어지게 됩니다.
- 그래서 viewWillAppear과 쌍이 맞는 viewWillDisappear에 removerObserver를 해줘야합니다.

```swift
import UIKit

class ViewController: UIViewController {
    let notiCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
	notiCenter.addObserver(self, selector: #selector(deivce(_:)),
                           name: NSNotification.Name.UIDeviceOrientationDidChange,
                           object: nil)        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
		NotificationCenter.default.removeObserver(self)
    }
    
@objc func deivce(_ noti: Notification) {
	print(noti)
	print("device")
	}
    
	deinit {	
	print("NotificationCenter end")
    }
}
```

- view가 호출될때마다 viewWillAppear이 호출되면서 addObserver를 하게 되고 다른 뷰로 넘어 갈때마다 viewWillDisappear되면서 removeObserver를 하게 됩니다.
- 또 클로져로 observer를 할 경우에는 return type이 NSObjectProtocol입니다. 클로져는 비동기이기 때문에 remove를 해줄때 NSObjectProtocol입니다에 담은 다음에 해제를 해줘야 합니다.

<br>

<br>

## Custom Notification.Name 

- 시스템에서 기본적으로 제공해주는 기능 외에 원하는 위치에서 Observer를 사용하기 위해서는 Notification.Name을 추가해줘야 합니다.

```swift
let myNoti = Notification.Name.init("myNoti")

extension Notification.Name {
    static let myNoti2 = Notification.Name.init("KMyNoti2")
}

class AntherViewController: UIViewController {
}
```

- class 외부에 let을 선언해서 상수로 만들어서 사용하는 방법
- Notification.Name을 extension해서 기능을 추가하는데 정적멤버로 상수를 만들어서 Name 초기화에 추가를 해 줍니다.
- 정적멤버는 앱 구동 초기에 메모리에 올라가서 언제든지 접근이 가능합니다.

<br>

<br>

## POST와 Custom addObserver

- 시스템에서 제공해주는 Notification.Name외에 커스텀으로 만들어준 이름을 사용할때는 노티를 보내주는 쪽에 POST를 넣어줘야합니다.

```swift
// 보내는 class
@IBAction private func postButton(_ sender: Any) {
	NotificationCenter.default.post(name: myNoti, object: sender)
 	}
```

- 받는쪽에서는 Post의 object 및 userInfo를 받을수 있으며, 타입은 각각 Any? 와 [AnyHashable : Any]? = nil 입니다.

```swift
// 받는 class
extension Notification.Name {
    static let myNoti2 = Notification.Name.init("KMyNoti2")
}

class AntherViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleNoti(_:)),
                                               name: Notification.Name.myNoti2,
                                               object: nil)
    }
    @objc private func handleNoti(_ noti: Notification) {
        print("handleNoti")
    }
```

- 커스텀해서 사용하는 방법 역시 뷰의 생성주기에 맞는 쌍에 removeObserver를 해줘야합니다.

<br>

<br>

## Notification을 사용해서 다른 뷰컨트롤러에 있는 뷰의 색상을 변경하기

- 아래와 같이 뷰컨트롤러에 있는 정보를 object: Any? 를 통해서 다음 뷰 컨트롤로 보낼수가 있습니다.

```swift
// POST
import UIKit

class ViewController: UIViewController {

    @IBOutlet private var redSilder: UISlider!
    @IBOutlet private var greenSilder: UISlider!
    @IBOutlet private var blueSilder: UISlider!
    @IBOutlet private var alphaSilder: UISlider!
    
    override func viewDidLoad() {
        tabBarController?.delegate = self
        
    }

    @IBAction func colorSetButton() {
        let color = UIColor(displayP3Red: CGFloat(redSilder.value),
                            green: CGFloat(greenSilder.value),
                            blue: CGFloat(blueSilder.value),
                            alpha: CGFloat(alphaSilder.value))
    NotificationCenter.default.post(name: Notification.Name.setColor, object: color)
    }
    
}
```

```swift
// Observer
import UIKit

extension Notification.Name {
    static let setColor = Notification.Name.init("setColor1")
}

class SecondViewController: UIViewController {

    @IBOutlet var subview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sendColor(_:)),
            name: Notification.Name.setColor,
            object: nil)
    }
    
    @objc func sendColor (_ noti: Notification ) {
        subview.backgroundColor = noti.object! as? UIColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit NotificationCenter")
    }
}
```

- 여기서는 object로 넘어 올때 Any?로 넘어왔기 때문에 UIColor로 typeCasting 해줘서 backgroundColor에 넣어줬습니다.










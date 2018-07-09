# Delegate

> (권한업무 등을) 위임하다.
>
> Delegate는 디자인 패턴입니다.

- 델리게이트 패턴은 자신이 할 일을 다른 인스턴스에게 대신 처리하도록 구현하는 디자인 패턴으로 객체지향에서 하나의 객체가 모든 일을 처리하는게 아니라 일의 일부를 다른 객체에 넘겨서 처리하도록 하는걸 뜻합니다.
- 요청하는 객체와 요청에 응답할 객체로 나누어 작성
- 주로 다음과 같은 상황에 사용에서 뷰는 보여주는거만 집중합니다.

  - 뷰가 받은 이벤트나 상태를 뷰컨트롤러에게 전달하여 처리하도록 함 (View -> ViewController)
  - 뷰 구성에 필요한 정보를 뷰컨트롤러가 결정하도록 함 (View <- ViewController) 
- 주요 코드는 숨기고 가능한 특정 상황에 대해서만 커스터마이징 할 수 있도록 제공 

<br>

<br>

## Delegate - 예를 들면

- AppDelegate와 소통하는 객체는 UIApplication 입니다. (App cycle을 참고)
- UIApplication은 상황이 생기면 자기가 결정하는게 아니라 AppDelegate에 물어봅니다.
- AppDelegate에 만들어준 동작을 하게 됩니다.
- UIApplication에서 동작하고 있는데 우리는 자세히 몰라도 (주요코드는 숨기고) 상황(백그라운드로 간다던지와 같은)만 받아서 코드를 커스텀마이징해서 사용하고 있습니다.

<br>

<br>

## Delegate 선언부

- 선언만 하고 실제로 어떤 기능을 할지는 알수가 없습니다. 

```swift
// class에 한정해서만 사용하도록 Type을 class로 합니다.
protocol CustomViewDelegate: class {
	func viewFrameChanged(newFrame:CGRect)
}

// 위에서 선언한 프로코콜을 타입으로 적어주면 delegate변수에는 CustomViewDelegate를 채택한 class 뷰만 담을수 있습니다. 
class CustomView: UIView {
	weak var delegate: CustomViewDelegate? // 프로토콜 타입

    override func layoutSubviews() {
        delegate?.viewFrameChanged(newFrame: frame)
    }
```

1. protocol을 생성합니다.

   ```swift
   protocol CustomViewDelegate: class {
   	func viewFrameChanged(newFrame:CGRect)
   }
   ```

2. class에 protocol을 type으로 가지는 delegate property를 생성합니다.

   ```swift
   weak var delegate: CustomViewDelegate?
   ```

3. Delegate instance의 method를 생성합니다.

   ```swift
   override func layoutSubviews() {
           delegate?.viewFrameChanged(newFrame: frame)
   }
   ```

   - `override func layoutSubviews() { delegate?.viewFrameChanged(newFrame: frame) }` 은 `class CustomView` 가 **UIView**를 상속받아서 override(재정의)해 사용하는 함수로 subview의 size나 position이 변경되면 호출이 됩니다. 

   - 여기서는 구현부에서 subview가 생성되면서 subview의 size가 변경되었고 변경되었기 때문에 layoutSubviews method가 실행되게되고, `delegate?.viewFrameChanged(newFrame: frame)`를 만나 **delegate?** 의 참조정보를 바탕으로 Delegate Method를 실행하게 됩니다.

   - 만약 구현부에서 아래와 같이 선언했다면

     ```swift
     let customView = CustomView()
     customView.delegate = self		// self == ViewController
     ```

   - Delegate?의 참조정보는 ViewController이 됩니다. 이는 ViewController가 Delegate Instance에 할당되었다면 분면 ViewController은 나와 같은 Protocol(속성)을 채택하였으며, 할당된 Type이 같기 때문에 Delegate method를 구현했다는것까지 알게 됩니다.

   - 그렇기 때문에 ViewController의 Delegate method를 실행할수 있게 됩니다.

<br>

<br>

## Delegate 구현부 

- 클래스는 다중 상속이 안되고 , 프로토콜만 다중상속이 가능합니다.

```swift
// CustomViewDelegate 프로토콜을 선택해서 사용하는 class는 무조건 포함된 메서드를 사용해야 합니다.
class ViewController: UIViewController, CustomViewDelegate {
	override func viewDidLoad() {
		super.viewDidLoad()

		let customView = CustomView()
		customView.delegate = self
		view.addSubview(customView)
	}

func viewFrameChanged(newFrame: CGRect) {
	// CustomView 의 프레임이 변경될 때마다 실행할 코드 작성
    print("Change frame : \(newFrame)")
}
```

1. class에 위에서 선언한 CustomViewDelegate 채택

2. 채택한 Delegate method 구현합니다.

   -  `func viewFrameChanged(newFrame: CGRect) { print("Change frame : \(newFrame)")  }` 입니다.
   - customView의 frame이 변경될때마다 delegate?를 통해서 method가 실행되게 됩니다.

3. 위임자(대리자)를 정해주는 과정을 해야 합니다.

   - 위임자를 지정해주기 전까지는 delegate?는 참조정보를 알수 없습니다. 
   - delegate?에 참조정보를 넣어줘야 나와 같은 속성을 채택하고(여기서는 protocol), Delegate method를 여기에 구현했다는것을 선언부에서 알수 있습니다.

   - 위임자를 정해주는 과정이 `customView.delegate = self` 입니다
   - ` ViewController` 은 ` customView` 가 하는 동작에 대해서는 간섭하지 않지만`  customView` 에 특정이벤트가 발생하면 ` ViewController` 에도 알려달라고 하는 상태입니다. 
   - 알려주는 방법은`  method` 를 호출해서 알려주는것이고, 이때 호출 되는 ` method` 가 ` Delegate Method` 입니다. 여기서는  `func viewFrameChanged(newFrame: CGRect) { print("Change frame : \(newFrame)") }` 가 실행하게 됩니다. (func의 실행을 Delegate 선언부에서 합니다.)
   - 이렇게 되면 `ViewController` 은 `func viewFrameChanged(newFrame: CGRect) {}` 이 언제 실행될지를 알수가 없고 실행이 되어야지만 알수 있게 됩니다.

<br>

<br>

## `customView.delegate` 에 self를 할당할수 있는 이유

프로토콜을 클래스와 다르게 다중상속이 가능한데, 여기서는 `ViewController`에 프로토콜인 `CustomViewDelegate`를 상속받았습니다.  

그렇기 때문에 선언부의 `weak var delegate: CustomViewDelegate?` 과 같은 Type인  `protocol CustomViewDelegate`가 되기 때문에 `customView.delegate에 ViewController(self)`를 할당 할수 있습니다.

<br>

<br>

## 예제로 보는 Delegate

![delegateExample.png](./img/delegateExample.png)



- `class CustomButton` 과 `class CustomView` 는 **선언부**, `ViewController` 은 **구현부**입니다.
- `protocol` 은 구현은 하지 않고 최소한으로 가져야할 **속성**이나 **method**를 정의만합니다.
- `protocol` 은 `class` 와 다르게 다중상속이 가능합니다.

<br>

```swift
import UIKit

class ViewController: UIViewController, CustomButtonDelegate, CustomViewDelegate {
    
    let button = CustomButton(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
    let customView = CustomView(frame: CGRect(x: 100, y: 250, width: 200, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.backgroundColor = .green
        customView.delegate = self
        view.addSubview(customView)
        
        button.delegate = self
        view.addSubview(button)
    }
    
    func viewFrameChanged(newFrame: CGRect) {
        print("Change frame : \(newFrame)")
    }
    
    func sayHello() {
        print("Hello Swift")
        let random = arc4random_uniform(100)
        customView.frame.size.height = CGFloat(random)
    }
}
```

구현부인 ViewController은 `CustomButtonDelegate` 와 `CustomViewDelegate` 를 채택하였습니다.

프로토콜을 타입으로 받으면 정의된 속성이나 메소드는 특정한 상황이 아니고서는 무조건 사용해야 합니다.

<br>

`CustomButtonDelegate` 를 채택했으니 선언부에서 만든어준 func func sayHello() { }를 사용해야하고

`CustomViewDelegate` 를 채택했으니 선언부에서 만들어준 func viewFrameChanged(newFrame: CGRect) {}를 사용해야합니다.

이 **Delegate method**를 통해서 `ViewController`은 `CustomButton`과 `CustomView`에 이벤트가 있다는것을 알게 됩니다.

<br>

그리고 `button` 은 `class CustomButton` 을 할당받았고,` custonView` 는 `CustomView` 를 할당받은 뒤

`customView.delegate = self` , `button.delegate = self` 로 위임자를 지정해줬습니다.

위임자(대리자)로 지정된 ViewController은 동작에는 관여하지 않지만 이벤트가 발생하면 Delegate의 속성에 따라 `customView` 와 `button` 에게 알려주게 되고 각각 정의된 **Delegate method**를 실행하게 됩니다.

<br>

동작하는 순서를 보면

1. 화면이 구성되면서 `CustomButtonDelegate` 와 `CustomViewDelegate` 채택됩니다.

2. `override func viewDidLoad() {}` 실행됩니다.

3. 최초 실행인 viewDidLoad()가 끝나고보니 subView로 생성된 `class CustomView`(선언부)의 사이즈가 `frame: CGRect(x: 100, y: 100, width: 200, height: 100)` 로 생성됩니다.

4. `subView` 의 위치를 새로잡거나 변경되면 `override func layoutSubviews() { }`라는 metohd가 실행이 되고,

   - func layoutSubviews()는 서브뷰에 위치를 새로잡으면 실행됩니다.

5. method 내부에 있는 `delegate?.viewFrameChanged(newFrame: frame)` 가 실행되면서 delegate?가 참조하는 `ViewController` (구현부)의 Delegate method가 실행됩니다. 여기서 `CustomView`의 frame값을 parameter로 구현부로 넘겨주게 되면서 변경된 값이 출력되게 됩니다. (여기서 customView는 ViewController에 있는 Delegate method를 실행하게 됩니다.)

   ```swift
       func viewFrameChanged(newFrame: CGRect) {
           print("Change frame : \(newFrame)")
       }
   ```

6. 그뒤 다시 CustomView(선언부)로 넘어가서 더이상 실행할 명령이 없으면 종료하게 됩니다.

<br>

<br>

1. Button을 클릭하면 class CustomButton이 실행되게 되면서, delegate?.sayHello() 가 실행되고 ViewConroller(구현부)의 함수를 동작하게 됩니다. 이 함수는 랜덤으로 100까지 나온 숫자로 customView의 높이값을 변경해주게 됩니다.

   ```swift
       func sayHello() {
           print("Hello Swift")
           let random = arc4random_uniform(100)
           customView.frame.size.height = CGFloat(random)
       }
   ```

2. 함수가 일을끝내가 되면 다시 CustomButton으로 돌아가서 더이상 할일이 없으면 종료를 하게됩니다.

3. 종료가 된뒤 CustomView(선언부)는 subView의 높이값이 변경된것을 알아서 `override func layoutSubviews() { }` method가 실행되게 되고 위쪽의 4번부터 6번까지가 실행되게 됩니다.

<br>

<br>

이와같이 Delegate를 사용해주면 선언해주는 곳과 구현해주는 곳을 나눠서 사용 할수 있습니다. 예를들어 알람창을 계속 사용하는데 매번마다 알람의 내용을 변경해야 한다면, 알람창을 선언해줘서 항상 사용하게 해주고 내용은 구현부에서 넣어서 동작하게 할수 있을겁니다.

<br>

<br>
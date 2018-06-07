## UITextFieldDelegate, delegate





```swift
import UIKit

final class ViewController: UIViewController, UITextFieldDelegate {

    lazy var textField = UITextField(frame: CGRect(x: view.center.x - 100, y: view.frame.minY + 120, width: 200, height: 50))
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self
    }
    
    // TextField should begin editing method called
    // Asks the delegate if editing should begin in the specified text field.
    // 지정된 텍스트필드 편집을 시작해야 하는경우 위임자(Delegate)를 호출한다.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드 편집을 위해 Delegate를 호출합니다.")
        return true
        // true - 편집가능, false - 편집 불가능 (킵보드가 안나옴)
    }
    
    //TextField did begin editing method called
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("텍스트 필드의 수정을 할수있는 메서드를 호출합니다.")
    }
    
    //TextField should clear method called
    //Asks the delegate if the text field’s current contents should be removed.
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("텍스트필드의 현재 내용을 제거해야 하는지을 위임자(Delegate)에게 묻습니다.")
        return true
        // 텍스트내용은 전부제거하려면 treu, 그렇지 않으면 false
    }
    
    // While entering the characters this method gets called
    // Asks the delegate if the specified text should be changed.
    // 지정된 텍스트를 변형해야 할때 Delegate에게 위임합니다.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("텍스트 필드에 텍스트를 입력하는 Delegate가 해당 메서드 호출 됩니다.(쓰거나 지우거나)")
        return true
        // 입력되고 쓸때마다 나오는건 알겠지만 뭘 하겠다는건지 모르겠다.
    }

    //TextField should return method called
    //Asks the delegate if the text field should process the pressing of the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("텍스트 필드에서 리턴 버튼을 눌러야 하는지 Delegate에게 묻습니다.")
		// textField.resignFirstResponder() 있어야 키보드가 사라집니다.
        textField.resignFirstResponder()
        return false
        // 버튼을 다른 식으로 사용 가능하다는것 같은데 잘 모르겠다. 생각처럼 구현이 안된다.
    }
    
    //TextField should end editing method called
    //Asks the delegate if editing should stop in the specified text field.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("텍스트필드에서 편집을 중지해야 하는지를 Delegate에게 묻습니다.")
        return true
        // false는 textFieldDidEndEditing(_:)가 실행되지 않습니다.
    }
    
    //TextField did end editing method called
    //Tells the delegate that editing stopped for the specified text field.
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("델리게이트가 텍스트필드에 대해 편집이 중지되었음을 알리며 텍스트 반환 = \(textField.text!)")
    }
}
```


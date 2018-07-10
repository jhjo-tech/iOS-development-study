# UIDevice

- 디바이스 이름 / 모델 / 화면 방향 등
- OS 이름 / 버전
- 인터페이스 형식 (phone, pad, tv 등)
- 배터리 정보
- 근접 센서 정보
- 멀티태스킹 지원 여부

<br>

<br>

## UIDevice: NSObject

- Device의 정보를 받아와서 사용할수 있습니다.

```swift
let device = UIDevice.current
```

<br>

<br>

## 시스템 버전 - systemVersion

```swift
let device = UIDevice.current

print("System Name :", device.systemName)
print((device.systemVersion as NSString).floatValue)

let systemVersion = device.systemVersion
print(systemVersion)

let splitVersion = systemVersion.split(separator: ".").compactMap { Int($0) }
print(splitVersion)

if splitVersion.count > 2 {
    label.text = "\(splitVersion[0]).\(splitVersion[1]).\(splitVersion[2])"
} else {
    label.text = "\(splitVersion[0]).\(splitVersion[1])"
}

```

- 버전은 Major, public Minor, non-public Minor로 구분해서 볼수 있습니다.

- Major는 기능적인 면이나 외관적인 것까지 변경되는것과 같이 큰 변경사항이 생길때 변경됩니다.

- Public Minor는 Major보다는 사소하게 변경될때 변경됩니다.

- Non-public Minor는 사용자는 변화를 알수 없지만 라이브러리를 추가하거나 개발자만 알고 있는 부분이 수정되는 경우에 변경됩니다.

- 예를들어 11.4.5에서 11은 Major, 4는 Public Minor, 5는 non-public Minor입니다.

  <br>

- System의 버전에 따라서 API나 라이브러리가 적용이 안되는 부분이 발생할수 있습니다. 그래서 시스템 버전을 디바이스에서 알아와서 버전에 맞게 사용해 줄수 있습니다. (available를 사용해서 버전별로 사용할수 있을것 같습니다.)

- ```swift
  if #available(iOS 11.0, *){ }
  ```

<br>

- `device.systemName`  는 디바이스 이름을 가져옵니다.

- `device.systemVersion` 는 시스템의 버전정보를 가져 옵니다. 반환 타입을 보면 String입니다.

- 그래서 반환되는 문자열을 FloatValue나 IntValue로 변경해서 사용하고 싶으면 다음과 같이 사용 가능합니다.

  ```swift
  (device.systemVersion as NSString).floatValue
  ```

<br>

- split를 사용해서 Major, Minor, non-public Minor을 나눠서 가져올수 있습니다.

  ```swift
  systemVersion.split(separator: ".")
  ```

- 예를들어 디바이스의 버전이 11.4라면 `.` 을 기준으로 split을 해서 11과 4를 나눠줍니다.

- 그리고 버전 비교를 쉽게 하기 위해 Int로 변환을 해주기 위해서 Int($0)를 합니다.

- 그리고 optional을 제거하기 위해서 .compactMap을 사용했습니다.

- 위와 같은 방법을 세부적인 버전별로 비교가 가능합니다.

<br>

<br>

## 아키텍처 - architecture 

- Device에 사용된 CPU의 종류에 따라 64비트, 32비트로 나뉠수 있습니다.
- 최근에는 거의 64비트이지 않을까.

```swift
// 1 1 0 1 1 1 1 0 0 0   Simulator
// 1 1 0 0 0 1 1 0 0 1   Device: iPhoneX
print("TARGET_OS_MAC : ", TARGET_OS_MAC)
print("TARGET_OS_IOS : ", TARGET_OS_IOS)
print("TARGET_CPU_X86 : ", TARGET_CPU_X86)
print("TARGET_CPU_X86_64 : ", TARGET_CPU_X86_64)
print("TARGET_OS_SIMULATOR : ", TARGET_OS_SIMULATOR)
print("TARGET_RT_64_BIT : ", TARGET_RT_64_BIT)
print("TARGET_RT_LITTLE_ENDIAN :", TARGET_RT_LITTLE_ENDIAN)
print("TARGET_RT_BIG_ENDIAN :", TARGET_RT_BIG_ENDIAN)
print("TARGET_CPU_ARM : ", TARGET_CPU_ARM)
print("TARGET_CPU_ARM64 : ", TARGET_CPU_ARM64)

```

- architecure를 사용해서 시뮬레이터인지 실제 디바이스인지를 확인 할수 있습니다.

  ```swift
  #if (arch(i386) || arch(x86_64)) && os(iOS)
  ```

  ```swift
  #if targetEnvironment(simulator)
  print("Simulator")
  label.text = "Simulator"
  #else
  print("Device")
  label.text = "Device"
  #endif
  ```

<br>

<br>

## deviceModel 

```swift
let device = UIDevice.current

print("name :", device.name)
print("model :", device.model)
print("localizedModel :", device.localizedModel)
```

- device.name - 디바이스 이름
- device.model - 디바이스 모델 ( iphone )
- device.localizedModel  - 한국에서는 모델과 같은 값이 나옵니다.

```swift
let device = UIDevice.current

print("userInterfaceIdiom :", device.userInterfaceIdiom)
```

- device.userInterfaceIdiom  - enum 타입으로 phone, pad, car, tv와 같은걸 구분해서 받습니다.
- device.userInterfaceIdiom는 원래 찍으면 rawValue로 출력이 되는데 아래와 같이 CustomStringConvertible을 별도로 해주면 String 값으로 출력이 가능합니다.

```swift
var userInterfaceIdiom: UIUserInterfaceIdiom { get }

extension UIUserInterfaceIdiom: CustomStringConvertible {
  public var description: String {
    switch self {
    case .unspecified: return "unspecified"
    case .phone: return "phone"
    case .pad: return "pad"
    case .tv: return "tv"
    case .carPlay: return "carPlay"
    }
  }
}
```

- device.orientation - 기기의 방향입니다. 
  - portrait - 일반적으로 세로로 보는 형태

  - portraitUpsideDown - 카메라가 아래로 가는 방향

  - landscapeLeft - 가로 모드일때 홈버튼이 right

  - landscapeRight - 가로모드 홈버튼이 left

  - faceUp - 화면이 위로 갈때

  - faceDown - 화면이 아래로 갈때

    ```swift
    let device = UIDevice.current
    
    print("orientation :", device.orientation)
    ```

- rawValue로 출력이 되기 때문에 CustomStringConvertible를 해서 String값으로 출력되게 할수 있습니다.

  ```swift
  extension UIDeviceOrientation: CustomStringConvertible {
    public var description: String {
      switch self {
      case .unknown: return "unknown"
      case .portrait: return "portrait"
      case .portraitUpsideDown: return "portraitUpsideDown"
      case .landscapeLeft: return "landscapeLeft"
      case .landscapeRight: return "landscapeRight"
      case .faceUp: return "faceUp"
      case .faceDown: return "faceDown"
      }
    }
  }
  ```

- device.isMultitaskingSupported 

  - 멀티테스킹을 지원하는지에 대한 여부를 나타냅니다.
  - 최신기기에서는 항상 true입니다.

  ```swift
  let device = UIDevice.current
  
  print("isMultitaskingSupported :", device.isMultitaskingSupported)
  ```

<br>

<br>

## battery 

- 디바이스의 베터리를 모티터링 하기 위해서는 `device.isBatteryMonitoringEnabled`  값이 true여야 합니다.

  ```swift
  device.isBatteryMonitoringEnabled = !device.isBatteryMonitoringEnabled
  ```

- device.batteryLevel은 현재 battryLevel을 가져옵니다. 단위는 %입니다.

  ```swift
  print("batteryState :", device.batteryState)
  print("batteryLevel :", device.batteryLevel)
  ```

- device.batteryState는 베터리의 상태로 4가지로 나눌수 있습니다.

  - unknown
  - unplugged - on battery, discharging
  - charging - plugged in, less than 100%
  - Full - plugged in, at 100%

- UIDeviceBatteryStateDidChange 를 받아와서 현재 상태가 변경될때마다 실행되는 notification이 있습니다.

  ```swift
  device.isBatteryMonitoringEnabled = !device.isBatteryMonitoringEnabled
  
  if device.isBatteryMonitoringEnabled {
      NotificationCenter.default.addObserver(
          forName: .UIDeviceBatteryStateDidChange, object: nil, queue: .main
      ) {
          if let device = $0.object as? UIDevice {
              print("batteryState :", device.batteryState)
              print("batteryLevel :", device.batteryLevel)
          }
      }
  } else {
      NotificationCenter.default.removeObserver(self, name: .UIDeviceBatteryStateDidChange, object: nil)
  }
  ```

- notification을 사용해서 핸드폰이 꺼지기 전에 데이터에 대한 저장을 요구하는 것과 같이 사용할수 있습니다.

<br>

<br>

## proximityMonitoring 

- 근접센서를 사용하는 방법입니다.

- 근접센서 역시 평소에는 동작을 하지 않고 있습니다.

  ```swift
  device.isProximityMonitoringEnabled = !device.isProximityMonitoringEnabled
  
  if device.isProximityMonitoringEnabled {
      NotificationCenter.default.addObserver(
          forName: .UIDeviceProximityStateDidChange, object: nil, queue: .main
      ) { [weak self] _ in
         print(UIDevice.current.proximityState)
         self?.label.text = "\(UIDevice.current.proximityState)"
        }
  } else {
      NotificationCenter.default.removeObserver(self, name: .UIDeviceProximityStateDidChange, object: nil)
  }
  ```

- device.isProximityMonitoringEnabled = !device.isProximityMonitoringEnabled 해주면 센서를 동작할수 있습니다.

- Notification을 사용해서 현재 상태를 모니터링 할수 있습니다.

- 베터리를 확인하거나 근접센서를 사용하는게 기본적으로 사용안함으로 되어 있는 이유는 언제 일어날지 모르는 일에 대해서 계속 모니터링을 하면 베터리에 미비하지만 영향이 갈수 있습니다. 그래서 필요 없을때는 사용하지 않는것이 좋을것 같습니다.

<br>

<br>

## beginOrientationNotification 

- Device orientation은 statusbar orientation과 동일하게 움직입니다.

- 디바이스가 가지는 방향과 statusbar의 방향을 다릅니다.

- Device orientation을 사용해서 앱의 방향이 돌아가지 않게 설정이 가능합니다. (check 해제)

- device.isGeneratingDeviceOrientationNotifications는 항상 켜져(on)있는 상태입니다.

- 디바이스를 움직일때마다 device.beginGeneratingDeviceOrientationNotifications() 는 중첩되어 쌓이게 됩니다.

- 중첩되어 쌓인다는건 해제시에도 여러번 해제를 해줘야 한다는것과 같습니다.

- Notification을 사용해서 현재 상태를 모니터링 할수있습니다.

  ```swift
  NotificationCenter.default.addObserver(
      self, selector: #selector(orientationDidChange(_:)), name: .UIDeviceOrientationDidChange, object: nil
  )
  ```

- 디바이스를 움직이고 싶지 않을때는 device.beginGeneratingDeviceOrientationNotifications()를 해제해 줘야 합니다.

- 하지만 해당 메서드는 중첩되서 만들어지기 때문에 몇개가 만들어 졌는데 확인하기 어려운 부분이 있습니다.

- 그래서 while 문을 사용해서 없어질때까지 해제합니다.

- 해제하는 메서드는 device.endGeneratingDeviceOrientationNotifications() 입니다.

  ```swift
  while device.isGeneratingDeviceOrientationNotifications {
      device.endGeneratingDeviceOrientationNotifications()
  }
  NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
  }
  ```

- 그리고 이렇게 해제된 상태에서는 화면을 이동해도 앱의 방향이 돌아가지 않습니다.

- 다시 앱의 방향을 돌아가게 하려면 device.beginGeneratingDeviceOrientationNotifications()을 호출해줘야합니다.
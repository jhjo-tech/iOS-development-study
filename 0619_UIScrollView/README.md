# UIScrollView

- A view that allows the scrolling and zooming of its contained views.
  - UIScrollView는 ScrollView에 포함된 view를 확대 / 축소 할수 있는 뷰입니다.
- 예를들면 앱에서 지도를 사용하려고 할때 지도의 모든 뷰를 보여 줄수는 없습니다. 그래서 ScrolView에 올려놓고 나타나는 영역만 뷰에 표시하고 나머지 영역은 옮기거나 해서 볼수 있습니다.

<br>

<br>

## ContentSize

- 현재 보여지는 뷰와 관계없이 스크롤 뷰가 표현할 수 있는 전체 컨텐츠의 크기입니다. 
- 현재 보여지는 뷰와 관계없는 사이즈 이기에 더 클수도 작을수도 있습니다.

<br>

<br>

## Managing the Content

- UIscrolView는 setContentOffset와 setZoomScale을 사용해서 화면에 보여지는 영역을 변경하면서 보여 줄수 있습니다.

```swift
scrollView.setContentOffset(contentOffset: CGPoint, animated: Bool)
```

- setContentOffset

  - ContentSize는 ScrollView가 표현할수 있는 전체 크기이기 때문에 실제로 뷰에 보여줄 사이즈를 정해줘야 합니다. 그게 bounds size입니다.

  - setContentOffset은 bounds 영역의 시작위치를 잡아줄수 있습니다.

  - 실제 사용될수 있는 코드로 보면 다음과 같습니다.

    ```swift
    let newOffset = CGPoint(x: scrollView.contentOffset.x + 150,
                           	y: scrollView.contentOffset.y)
    scrollView.setContentOffset(newOffset, animated: true)
    ```

    `scrollView.contentOffset.x`를 사용해서 컨텐츠 뷰의 위치가 스크롤뷰에서 얼마나 offset이 얼마나 이동해 있는지를 확인(스크롤뷰에서 현재 뷰의 x)해서 +150만큼을 이동시킨 x값을 `setContentOffset`에 넣게 됩니다. 결과는 현재뷰에서 x값으로 150만큼 이동하게 됩니다. 

  <br>

  <br>

```swift
scrollView.setZoomScale(scale: CGFloat, animated: Bool)
```

- setZoomScale

  - scale값을 넣어서 Zoom 배율을 부동 소수점 값으로 줄수 있습니다.

  - The new scale value should be between the minimumZoomScale and the maximumZoomScale.

    - 새로운 scale 값은 가장 작은 스케일과 가장 큰 스케일의 사이에 있어야 합니다.

    ```swift
    let ratio = scrollView.frame.width / imageView.image!.size.width
    scrollView.setZoomScale(ratio, animated: true)
    ```

  - `scrollView.frame.width / imageView.image!.size.width`를 사용해서 이미지가 스크롤뷰의 몇배인지를 구할수 있습니다

  - 구해진 값을 setZoomScale의 scale값으로 주면 이미지 전체를 볼수있는 Zoom이 됩니다.

<br>

<br>

```swift
scrollView.isPagingEnabled = true
```

- isPagingEnabled
  - If the value of this property is true, the scroll view stops on multiples of the scroll view’s bounds when the user scrolls. 
  - property를 true로 하면 scrollView의 bounds(현재 보여지는 뷰)의 2배의 위치에서 멈추가 scroll View가 멈추게됩니다.

<br>

<br>

```swift
extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) { }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) { }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) { }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
```

- UIScrollerViewDelegate
  - 델리게이트를 사용하면 특정 시점에서 원하는 동작을 하게 할수 있습니다.
  - 더 많은 method가 있습니다.

<br>

```swift
func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) { }
```

- 대리자/위임자에게 Zoom(확대 / 축소)이 시작되는것을 알립니다.
- Zoom(확대 / 축소)을 시작하기전의 상태정보를 저장하거나 추가 작업을 할수 있습니다.

<br>

```swift
func scrollViewDidZoom(_ scrollView: UIScrollView) { }
```

- 대리자/위임자에게 스크롤뷰의 확대 / 축소 배율이 변경되었음을 알립니다.
- `scrollView.setZoomScale(scale, animated: true)` 가 실행뒤에 나옵니다.

<br>

```swift
func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) { }
```

- 대리자/위임자에게 스크롤뷰의 확대 / 축소가 종료되었음을 알립니다.
- 에니메이션이 변경되거나 확대 / 축소 관련 제스처(손가락 두개를 사용해서 확대를 하는것과 같은)를 했을때도 실행됩니다.

<br>

```swift
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
```

- Zoom을 사용했을때 적용 될 뷰를 정해줍니다.

<br>

```swift
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
```

- 대리자 / 위임자에게 스크롤뷰가 감속을 종료 했다는것을 알립니다. (뷰의 이동이 종료 되었을때)

<br>

```swift
pageControl.numberOfPages += 1
pageControl.currentPage = 1
```

- `pageControl.numberOfPages`에 입력하는 숫자만큼 하단에 점으로 표시해줍니다.
- `pageControl.currentPage`는 현재 페이지를 흰색점으로 표시 할수 있습니다. 기본값 0은 첫번째 페이지이며, 페이지를 만들때마다 숫자를 넘겨주면 `pageControl.numberOfPages`로 표시한 범위 내에서 흰색점을 표시 할수 있습니다. 
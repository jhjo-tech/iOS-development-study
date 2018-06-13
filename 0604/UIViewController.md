# UIViewController



### UIViewController

> App 구조의 뼈대, 모든 앱에 반드시 하나 이상이며 대부분 많은 수의 ViewController로 구성되어 있습니다.



1개가 있을때는 반드시 window의 rootView에 들어가게 되어 있고, 추가 하면 SubView에 들어가게 됩니다.



### View Management 

> 가장 중요한 역할 - 뷰 계층 관리 
>
> 모든 뷰컨트롤러마다 RootView를 지니며, 화면에 표시하기 위해서는 해당 RootView 계층에 속해야 함 

뷰컨트롤러에서 self.view를 하면 view가 만들어져있습니다.

ViewController에는 반드시 view가 1개 들어가 있습니다.

스토리보드에 ViewController을 올리면 view가 하나 따라오는데 그게 RootView입니다.

window>viewcontroller>rootview>view

타고타고 올라가서 계층에 포함이 되어야 합니다.





### Two types of view controllers 

크게 2종료 입니다.

#### Content View Controllers 

> \- 모든 뷰를 단독으로 관리  
>
> \- UIViewController, UITableViewController, UICollectionViewController 등  



<br>

#### Containter View Controllers  

> 자체 뷰 + 하나 이상의 자식 뷰 컨트롤러가 가진 루트뷰 관리   
>
> 컨테이너는 컨텐츠를 관리하는 것이 아니라 루트뷰만 관리하며 컨테이너 디자인에 따라 크기 조정 
>
> UINavigationController, UITabbarController, UIPageViewController 등 



그림



왼쪽에도 뷰컨트롤러, 오른쪽데 뷰 컨트롤러입니다.

split vidw controller을 양쪽 뷰의 사이즈 및 화면을 보여주는 정도만 담당하고, 실제로 Viewcontroller로 관리

Content 는 무조건

Containter는 있을수도 없을수도 있고 





### Data Marshaling 

> MVC (Model - View - Controller)
>
> 자신이 관리하는 View 와 Data 간 중개 역할 (직렬화)

MVC 패턴을 사용한다는것





### 이벤트 처리 (User Interactions)

> 뷰컨트롤러는 Responder 객체 : 직접 이벤트를 받아 처리 가능하나 일반적으로 지양 
>
> 뷰가 그 자신의 터치 이벤트를 연관된 객체(보통 뷰컨트롤러)에 action 메서드나 delegate 로 전달 

뷰컨트롤러도 Responder 객체기때문에 이벤트 처리가 가능하나, 



뷰가 뷰 컨트롤러에게 전달하는 형태

아니면 나중에 배울 델리게이트 에게 전달하는 형태로 사용을 넘기게 됩니다.





### 뷰컨트롤러가하는 일 (Resource Management )

> 뷰컨트롤러가 생성한 모든 뷰와 객체들은 뷰컨트롤러의 책임
>
> 뷰컨트롤러의 LifeCycle 에 따라 생성되었다가 자동 소멸되기도 하지만 ARC 개념에 맞게 관리 필요
>
> 메모리 부족 시 didReceiveMemoryWarning 메서드에서 캐시 메모리 등 꼭 유지하지 않아도 되는 메 모리들은 정리 필요 



뷰 컨트롤러가 해당 뷰들에 대해서 관리할 책임이 있습니다.

그래서 뷰를 생성하고, 소멸시키고, 잡고 있다가 놔주고 하는 방식으로 합니다.

디드리시브 메모리 워닝(메모리부족) 시스템이 뷰컨트롤러에게 메모리가 부족하다고 알림을 보내주고 그 알림을 받았을때 지금 당장 필요하지 않거나 (이미지같은) 걸 제거해주거나 나중에 다시 열때 사용하도록 구현

그렇지 않으면 앱을 죽여버립니다.





### Adaptivity

> 뷰컨트롤러는 뷰의 표현을 책임지고, 현재 환경에 적절한 방법으로 적용되도록 할 책임을 가짐 

기기의 사이즈가 다양해지고 기기도 다양해 지면서 생긴게 가로 세로 길이가 다른데

이거에 따라서 ios9부터 레귤러 컴팩트 가 생겼습니다.

길이에 따른 비율 개념입니다.



이런것들에 따라서 뷰의 표현을 책임지고 환경에 적절한 방법으로 적용되도록 할 책임

활용하기도 하고

비율같은거나 수치같은걸 해서 오토레이아웃을 잡기도 합니다.





## The View Controller Hierarchy

> 뷰컨트롤러 구조



### The Root View Controller 

> UIWindow 는 그 자체로는 유저에게 보여지는 컨텐츠를 가지지 못함 
>
> Window는 정확히 하나의 Root View Controller 를 가지는데 이것을 통해 컨텐츠를 표현 

컨텐트뷰컨트롤러



연초록 - 화면

최종적으로 연초록 화면이 보여집니다.



UIWinodws도 UI뷰의 서브클레스 입니다.

window는 기본 바탕 화면 (컨텐츠를 가지지 않는다)

뷰 컨트롤로에 있는 rootview가 가진 컨텐츠를 화면을 표시합니다.



### Container View Controllers 



### Presented View Controllers 

### A container & a presented View Controller 



네비게이션 컨트롤러에 뷰 컨트롤러를 여러가 차일드뷰컨트롤러로 넣을수 있게 되고 스택처럼쌓여서 하나씩 보이게 되는데

거기에 대해서 present를 하게 되는게 보여지게되고

만약 프레젠트가없으면 차일드에서 가장 마지막에 있는게 보여지게 됩니다.





## View Controller Life Cycle 







### 실제로 해보면

> 스토리 보드에서 ViewController를 3개를 만들어서 NEXT를 누르면 다음 화면으로 넘어가게 했습니다.

처음 화면이 켜지면

-viewDidLoad // Controller View가 memory에 로드 된 후 호출합니다.

--viewWillAppear 

// View가 View hierarchy(계층)에 추가 될 예정임을 ViewController에 알립니다. 즉, View가 새롭게 호출 된다는걸 ViewController에게 알립니다.

---viewDidAppear 

// View가 View hierarchy에 추가되었음을 ViewController에 알립니다.



다음 화면을 불러오면

-viewDidLoad

----viewWillDisappear

 // View가 View hierarchy에서 삭제되려고 한다는걸 ViewController에 알립니다.

--viewWillAppear

---viewDidAppear

-----viewDidDisappear 

// View가 View hierarchy에서 삭제 된 것을 ViewController에 알립니다.



세번째 화면을 불러오면

-viewDidLoad

----viewWillDisappear // 사라질거라는걸 알려줍니다.

--viewWillAppear // 새롭게 호출 된다는걸 알려줍니다.

---viewDidAppear // 제대로 호출이 되면 알려줍니다.

-----viewDidDisappear // 이전에 불러온 뷰가 사라졌습니다.





프레젠트 모달은 계속 뷰를 생성하겠다는 걸로 백버튼을 모달로 연결하면

계속 뷰가 생성됩니다.
























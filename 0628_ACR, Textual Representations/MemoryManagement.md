# Memory Management

<br>

<br>



## Memory Management without ARC

<br>

ARC가 없을때 어떻게 관리 했을까.

1. Garbage Collection

   - 정기적으로 Garbage Collector가 동작하여 더이상 사용되지 않는(필요없다고 판단되면) 메모리를 반환하는 형식
   - iOS는 사용된적이 없고 OS X에서 지원했으나 Mountain Lion (버전 10.8)부터 사용할수 없게 되었습니다.

   <br>

2. Manual Retain-Release, Manual Referece Counting

   - 메모리 관리 코드를 직접 호출해서 메모리를 할당함. 개발자가 직접 관리를 해줘야 했었습니다.

   - RC(Reference Counting) 를 통해 메모리를 수동으로 관리한는 방식
   - retain / release / autorelease 등의 메모리 관리 코드를 직접 호출 
   - 개발자가 명시적으로 RC 를 증가시키고 감소시키는 작업 수행 





그렇기 때문에

### MRR

- RC 에 대한 이해 필요 (Reference Counting / Retain Count / Reference Count) 
- Objective-C 에서는 ARC 해제 가능 

이미지



Build Settings에서 Objectiva-C Automatic Reference Counting을 No라고 하면 사용이 가능



code로 보면

argc을 할당하면 refer counting가 1이 생기고



relese를 하면 counting가를 한개씩 내릴수있고

```objective-c
int main(int argc, const char * argv[]) {
       
Person *man = [[Person alloc] init];			// count: 1
[man doSomething];

[man retain];									// count: 2
[man doSomething];
 
// [man release];
[man doSomething];								// count: 2
[man release];									// count: 1
[man release];									// count: 0
}
```



Reference Counting 



이미지 파괴되는 과정을 나타내는이미지

(Reference counting을 관리하는 과정입니다.)





### Leak vs Dangling Pointer 



카운트 할당과 해제는 균형이 맞아야 함  

- alloc , retain 이 많을 경우는 Memory Leak 발생  (사용하지 않는데 객체가 남아있게 됨)
- release 가 많을 경우 Dangling Pointer (허상, 고아) 발생  (같은데서 릴리즈를 너무 많이 해서 다음과정에서 -1이 되버리면 0이되는순간 객체는 파괴되는데 거기에 접근하거나 카운터를 내릴려고 하면 파괴되어있는 곳에 접근을 하게 되어 이미 날라가버린 메모리에 접근하는것과 같기때문에 문제가 발생. 운이 좋으면 에러가 발생하지 않지만 보통 런타임 에러가 발생하게 됩니다)
- Dangling Pointer는 해제된 주소를 가르킨다는 겁니다.



### MemoryManagement Is Hard 

이외에도 룰 및 컨벤션을 알아야하고

개발을 할때마다 새로해줘야 하고

### MemoryManagement Is Hard 

이걸 다 알아야 개발이 가능했다.



그래서 꼬인 코드들이 발생하게 되고



그걸 조금이라도 도와주려고 

### Xcode Static Analyzer 

빌드 시킬때 조금더 분석하게 해서 사용하는 경우가 있습니다.

이런걸 사용하면서 내가 제대로 사용하고 있는지를 확인하면서 진행했어야합니다.

(완벽하지 도 않고)



그래서 

## ARC 등장

## ARC (Automatic Reference Counting) 

2011년에 등장

- RC 자동 관리 방식 (WWDC 2011 발표)  
- 컴파일러가 개발자를 대신하여 메모리 관리 코드를 적절한 위치에 자동으로 삽입 
-  GC 처럼 런타임이 아닌 컴파일 단에서 처리 (Heap 에 대한 스캔 불필요 / 앱 일시 정지 현상 없음)
-  메모리 관리 이슈를 줄이고 개발자가 코딩 자체에 집중할 수 있도록 함 



가비지 컬렉터는 런타임에서 시스템 전반적으로 도는 타이밍이 있어서 전체를 한번에 처리하게 됩니다.

가끔 한번씩 앱같은게 사용하던 프로그램이 일시정지하는 현상이 느낌이 들때 메모리를 회수하는 과정일 수도 있다.



컴파일 단계에서 미리 회수할 지점을 미리 정리한 상태에서 시작하기 때문에 일시정지 현상이 없고 런타임 중에서 Heap에 대한 스캔을 할 필요가 없습니다.





클래스에만 관련이 있고 참조타입에는 관련이 없습니다.

스위프트에서는 밸류타입 위주로 사용하는것도 ARC에 대한 부담을 관리하기 위해서 입니다.

- ARC 는 클래스의 인스턴스에만 적용 (Class - Reference 타입 , Struct / Enum - Value 타입) 
- 활성화된 참조카운트가 하나라도 있을 경우 메모리에서 해제 되지 않음 (참조 카운트는 0이 되어야 메모리에서 해제됩니다.)

 참조 타입

- 강한 참조 (Strong) : 기본값. 참조될 때마다 참조 카운트 1 증가 
- 약한 참조 (Weak), 미소유 참조 (Unowned) : 참조 카운트를 증가시키지 않음
- 강한 순환 참조 (Strong Reference Cycles) 에 대한 주의 필요 

참조들끼리 계속 카운터를 하기 때문에 메모리에서 해제가 안되는 상황이 생기게 됩니다. 그래서 강한 순환 참조를 주의해야 합니다.



### Strong Reference Cycle 

\- 객체에 접근 가능한 모든 연결을 끊었음에도 순환 참조로 인해   활성화된 참조 카운트가 남아 있어 메모리 누수가 발생하는 현상 

\- 앱의 실행이 느려지거나 오동작 또는 오류를 발생시키는 원인이 됨 















플레이그라운드






























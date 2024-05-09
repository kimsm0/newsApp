# newsApp

‼️Build 
info.plist 파일의 API_KEY 값에 아래 키를 넣은 후 빌드 진행. 
2e5866705ef741519082fb8f92136cb8

🍏 구조
RIBs 아키텍쳐 

🍏 모듈화 
1. NewsHome 패키지 
- 뉴스 리스트를 보여주는 NewsMain 리블렛과
메인에서 기사를 선택하면 이동되는 NewsDetail 리블렛
으로 구성되어 있다.

2. WebView 패키지
- WebView 리블렛이 구현되어 있으며, url을 주입받아 웹뷰를 로드한다. 

3. Platform 패키지
- 공통으로 사용되는 Extensions, Utils, CustomUI 등으로 구성되어 있다.   


🍏 비동기/선언적 프로그래밍
- 비동기 프로그래밍을 위해 Combine 사용. 

 
🍏 구조 

💡 
- NewsHome 패키지 
- NewsMain, NewsDetail 리블렛으로 구성
- AppRoot리블렛에서 NewsMain을 하위로 attach 하여 시작한다. RootBuilder에서 메인 리블렛에서 필요한 repository를 주입받는다. 
- 메인화면에서 기사를 탭하면 NewsDetail을 child 로 attach한다. 
- NewsDetail에서는 선택한 기사의 index와, repository를 주입받도록 되어 있다. 
👉 SceneDelegate에서 UITESTING Config일 경우에는, TestDouble의 testMode에 맞는 리블렛을 바로 연결하기 위해, AppRootTest 리블렛으로 연결되어 있다. 

💡 
- Repository
- Network Request를 진행한다. 
- 테스트시 비동기 작업의 스케줄러 설정이 필요하여, 스케줄러를 외부에서 주입받도록 되어 있다. 


💡 
- Entity: 프로젝트 내부에서 사용될 데이터 모델 (DTO를 기반으로 생성됨)
- DTO: 외부에서 전달 받은 데이터 모델
- 외부 데이터 모델의 영향도를 줄이기 위해 데이터 모델 구분하여 구성되어 있다. 


💡 TEST
- UI Test는 UITESTING Config를 추가하여, baseURL을 local로 변경,
AppURLProtocol 클래스를 통해 Mock Data를 리턴하도록 되어있다. 
고정된 데이터 값을 통해, 외부로 부터 분리하여 항상 일관된 테스트 결과를 리턴할 수 있도록 구현하였다. 

- UI/ Unit TEST 진행시 공통으로 사용될 수 있는 Mock Data의 경우 TestDouble로 생성하여 항상 고정된 값을 리턴할 수 있도록 TestSupport 모듈이 생성되어 있다. 
- Test Target에서는 Unit Test 진행시에 필요한 router, presenter, depengency 등을 mock 데이터로 구성하였다. 비지니스 로직을 담당하고 있는 interator의 테스트를 통해, 다른 외부 값을 고정시켰을 때, 항상 동일한 결과가 도출되는지 확인한다. 
- API를 호출하는 repository의 경우, 공통으로 사용되게 Test Support 모듈 안에 포함되어 있다. 

🍏 오픈소스 
1. ModernRIBs
- RIBs 아키텍처와 Combine을 함께 사용하기 위한 프레임워크. 
2. Kingfisher
- 이미지 다운로드 및 캐싱 처리를 간단하게 처리하기 위한 프레임워크. 
3. SnapKit
- Code Base UI 구현을 위한 프레임워크  
4. Then
- 프로퍼티 할당을 블록내에서 설정할 수 있도록 해주는 프레임워크로, 코드의 가독성을 향상시키고 불필요한 코드 중복을 줄이기 위한 프레임워크 .
5. CombineExt
- Combine의 확장된 Operator와 Publisher등을 사용하기 위한 프레임워크
6. combine-schedulers
- Test 진행시 비동기 처리를 제외하기 위한 확장된 스케줄러 프레임워크 



🍏 Test
- Scheme을 Test 하고자 하는 모듈로 변경 후 Test 진행 (Command + U)


/**
 @class SceneDelegate.swift
 @date
 @writer kimsoomin
 @brief
 @update history
 -
 */
import UIKit
import ModernRIBs
import NewsTestSupport

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var launchRouter: LaunchRouting?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        
        #if UITESTING
        TestDouble.testMode = .main
        let rootRouter = AppRootTestBuilder(dependency: AppComponent()).build()
        self.launchRouter = rootRouter
        launchRouter?.launch(from: window!)
        #else
        let rootRouter = AppRootBuilder(dependency: AppComponent()).build()
        self.launchRouter = rootRouter
        launchRouter?.launch(from: window!)
        #endif        
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}


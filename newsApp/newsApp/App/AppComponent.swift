/**
 @class
 @date
 @writer kimsoomin
 @brief
 @update history
 -
 */

import Foundation
import ModernRIBs

final class AppComponent: Component<EmptyDependency>, AppRootDependency {
  
  init() {
    super.init(dependency: EmptyComponent())
  }
  
}

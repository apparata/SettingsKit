//
//  Copyright © 2016 Apparata AB. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public func openAppSettings(completionHandler: ((_ success: Bool) -> Void)? = nil) {
    guard let appSettingsURL = URL(string: UIApplication.openSettingsURLString) else {
        completionHandler?(false)
        return
    }
    guard UIApplication.shared.canOpenURL(appSettingsURL) else {
        completionHandler?(false)
        return
    }
    UIApplication.shared.open(appSettingsURL, options: [:], completionHandler: completionHandler)
}

#endif


# Fizo Integrate 

```bash
import Fizo
```

## Privacy-sensitive data accessed 
```bash
+ NSAppTransportSecurity - NSAllowsArbitraryLoads : for uat environment
+ NSCameraUsageDescription
+ NSPhotoLibraryUsageDescription
```

## Font
```bash
Folder: FizoFonts.zip
```
##  Config Environment 

FizoManger

```bash
func update(enviroment: FizoEnviromentType)
```
With: 
```bash
enum FizoEnviromentType {
    case dev
    case uat
    case production
}
```

Usage

```bash
import Fizo

FizoManger.shared.update(enviroment: .production)
```
## Main View Controller 

FizoManger

```bash
func showRootFizo(on rootVC: UIViewController,
                 vnPostUser: VnPostUserInfoDisplay) -> UIViewController?
```
With: 
```bash
public protocol VnPostUserInfoDisplay {
    var companyId: String? { get }
    var email: String? { get }
    var employeeCode: String? { get }
    var mobile: String? { get }
    var orgCode: String? { get }
    var orgId: String? { get }
    var orgTitleId: String? { get }
    var userProfileId: String? { get }
    var uuid: String? { get }
}
```

Usage

```bash
import Fizo

FizoManger.shared.showRootFizo(on: self, vnPostUser: userModel)
```

## Notification
 

Register:
```bash

func registerDeviceToken(vnpostUserProfileId: String,
                                  vnpostUuid: String,
                                 deviceToken: String)
```
Usage
```bash
FizoManger.shared.registerDeviceToken(vnpostUserProfileId: userProfileId,
                                               vnpostUuid: uuid,
                                              deviceToken: token)
```

Receive response:
```bash
func processNotify(info: [AnyHashable : Any],
             vnPostUser: VnPostUserInfoDisplay)
```
Usage
```bash
FizoManger.shared.processNotify(info: userInfo,
                          vnPostUser: userModel)
```
## Notification Detail
 

FizoManger

```bash
func showNotifyDetail(viewController: UIViewController? = nil, notifyId: String)
```

Usage

```bash
import Fizo

FizoManger.shared.showNotifyDetail(notifyId: notifyId)
```

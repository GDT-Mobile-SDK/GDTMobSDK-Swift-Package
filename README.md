# 优量汇 SDK — Swift Package Manager

本仓库为优量汇 iOS SDK 的 Swift Package Manager（SPM）分发仓库，仅存放包描述文件
（`Package.swift`）。

SDK 的实际二进制由 CDN 提供，SPM 在解析依赖时会自动下载，**无需手动下载**。

---

## 一、环境要求

| 项 | 要求 |
|----|------|
| Xcode | 15.0 及以上 |
| iOS | 11.0 及以上 |
| Swift | 5.9 及以上 |
| 架构 | 真机 arm64；模拟器 arm64 / x86_64 |

---

## 二、接入步骤

### 1. 添加依赖

在 Xcode 中：

```
File → Add Package Dependencies…
```

在搜索框中输入本仓库地址，Dependency Rule 选择 **Up to Next Major Version**，
版本填写目标版本号（例如 `4.16.20`）：

```
https://github.com/GDT-Mobile-SDK/GDTMobSDK-Swift-Package.git
```

点击 **Add Package**，勾选 `GDTMobSDK` 产品后完成。

> 该地址为 GitHub 公网仓库，克隆 `Package.swift` 时需能访问 GitHub。
> SDK 二进制由国内 CDN 提供，不受此影响。

### 2. 引入头文件

```swift
import GDTMobSDK
```

```objective-c
@import GDTMobSDK;
// 或
#import <GDTMobSDK/GDTMobSDK.h>
```

### 3. 代码调用

```objective-c
// 初始化 SDK
[GDTSDKConfig initWithAppId:@"你的AppId"];
[GDTSDKConfig startWithCompletionHandler:^(BOOL success, NSError *error) {
    NSLog(@"%@", error);
}];

// 加载开屏广告
self.splashAd = [[GDTSplashAd alloc] initWithPlacementId:@"你的广告位ID"];
self.splashAd.delegate = self;
self.splashAd.fetchDelay = 5.0;
[self.splashAd loadAd];
```

### 4. 必须配置：-ObjC 链接标志

**SDK 为 Objective-C 实现，宿主工程必须添加 `-ObjC` 链接标志**，否则 SDK 内的
Objective-C 类/Category 不会被加载，运行时会因找不到类而崩溃。

配置方式：

1. 选中 **App Target** → **Build Settings**
2. 搜索 **Other Linker Flags**
3. 添加：

```
-ObjC
```

> 该标志无法由 SPM 的 `Package.swift` 自动声明（SPM 不支持 `unsafeFlags`），
> 需在宿主工程手动配置一次。

---

## 三、关于动态库嵌入（无需手动配置）

**GDTMobSDK 与 Tquic 均为动态库（`.framework`），运行时需随 App 一起嵌入（Embed）。**

通过 SPM 的 `binaryTarget` 引入动态 xcframework 时，**Xcode 在构建宿主 App 时会自动完成嵌入与签名**，
会把两个 framework 自动拷贝到 `App.app/Frameworks/` 并代签——**无需**像手动拖拽 framework 那样
在 General → Frameworks 里手动设置「Embed & Sign」。

### 唯一需要确认的一项：Runpath Search Paths

请确认 App Target 的 **Build Settings → Runpath Search Paths（`LD_RUNPATH_SEARCH_PATHS`）** 包含：

```
@executable_path/Frameworks
```

> Xcode 新建的 App 工程默认即带此项，通常无需改动。只有在从旧工程迁移、
> 或曾手动清空过该配置时才需补上。缺失时运行时会报：
>
> ```
> dyld: Library not loaded: @rpath/Tquic.framework/Tquic
>   Reason: image not found
> ```

---

## 四、常见问题

### Q1：模拟器构建报架构不匹配

请确认 Xcode 为 15.0 及以上。SDK 的模拟器切片包含 **arm64 + x86_64** 双架构，
Apple Silicon 与 Intel Mac 均可直接构建，无需 Rosetta。

### Q2：如何检查是否有新版本

SPM 通过 **Git tag** 管理版本。检查更新方式：

- **Xcode**：`File → Packages → Update to Latest Package Versions`
- **命令行**：`swift package update`

> 新版本发布后会在本仓库打对应 tag，SPM 执行更新时自动解析到符合语义化版本
> 规则的最新版本。

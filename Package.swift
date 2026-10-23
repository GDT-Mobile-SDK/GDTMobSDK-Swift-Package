// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "GDTMobSDK",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "GDTMobSDK", targets: ["GDTMobSDKTarget"])
    ],
    dependencies: [],
    targets: [
        // wrapper target：binaryTarget 无法直接挂依赖与链接设置，
        // 故用一层普通 target 承载 Tquic 依赖和系统库链接声明。
        .target(
            name: "GDTMobSDKTarget",
            dependencies: [
                "GDTMobSDKBin",
                "Tquic"
            ],
            path: "GDTMobSDKTarget",
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedLibrary("sqlite3"),
                .linkedLibrary("c++"),
                .linkedLibrary("c++abi"),
                .linkedFramework("StoreKit"),
                .linkedFramework("Security"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("AdSupport"),
                .linkedFramework("CoreLocation"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("JavaScriptCore"),
                .linkedFramework("Accelerate"),
                .linkedFramework("CoreML"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("CFNetwork"),
                .linkedFramework("WebKit", .when(platforms: [.iOS]))
            ]
        ),
        .binaryTarget(
            name: "GDTMobSDKBin",
            url: "https://qzs.gdtimg.com/union/res/ios/sdk/GDTMobSDK_4.16.102_284a0e32d316752402b8bb7f3a927883.xcframework.zip",
            checksum: "e2b18f7feb6a2805544cac49d2e0397e2249eeeba79783b188204e92052d6745"
        ),
        .binaryTarget(
            name: "Tquic",
            url: "https://qzs.gdtimg.com/union/res/ios/sdk/Tquic_4.16.102_7bfca369b77c85de88d576d6a3c1d1f9.xcframework.zip",
            checksum: "b93686e24c9e0277cf4adc7f1abf1a800c6657e2899b9ae7afea59d33df94568"
        )
    ]
)

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
            url: "https://qzs.gdtimg.com/union/res/ios/sdk/GDTMobSDK_4.16.102_2631b4bfd1cf163e18b9039c1b3ad210.xcframework.zip",
            checksum: "2d739ab7fa44fdd67001fb0463980383e9ce24ab95fed895685e6a117dd144d4"
        ),
        .binaryTarget(
            name: "Tquic",
            url: "https://qzs.gdtimg.com/union/res/ios/sdk/Tquic_4.16.102_cfa09eb76c827ec58883a650db4d2c33.xcframework.zip",
            checksum: "a2b5a2fe28f88477cb9a05f88d8f2d2d370abe69bbce889f2f53f36a89f434f4"
        )
    ]
)

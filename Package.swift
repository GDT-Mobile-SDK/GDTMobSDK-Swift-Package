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
            url: "https://qzs.gdtimg.com/union/res/ios/sdk/GDTMobSDK_4.16.100_151ac7ba661bdeee567026a85f9978ed1.xcframework.zip",
            checksum: "74f6b8529534eaa29f3bce7b5ad7cfe43e50e6eae620a1cc732e975212bf0312"
        ),
        .binaryTarget(
            name: "Tquic",
            url: "https://qzs.gdtimg.com/union/res/ios/sdk/Tquic_4.16.100_4acde3ee41fb5cf7ed36912bed91085d1.xcframework.zip",
            checksum: "3512549ac0310ae3e56227c7b12ed00d5e2b57a55777c07ca64fcc61a44fd734"
        )
    ]
)

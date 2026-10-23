//
//  GDTNativeExpressAdView.h (shim)
//
//  兼容垫片：原 CocoaPods 接入时宿主用引号形式 #import "GDTNativeExpressAdView.h"，依赖
//  podspec 的 HEADER_SEARCH_PATHS 把 framework 的 Headers 目录加入搜索路径。
//  转为 Swift Package 接入后该机制不存在，引号 import 会报 file not found。
//
//  本文件位于 wrapper target(GDTMobSDKTarget) 的 publicHeadersPath(include/) 下，
//  SPM 会把该目录加入下游（宿主 app）的 header search path，故宿主的
//  #import "GDTNativeExpressAdView.h" 会命中此 shim 并转发到真正的 framework module，
//  从而在不改动宿主接入代码的前提下编译通过。
//
//  本文件由 gen_spm_files.sh 自动生成，请勿手改。
//

#import <GDTMobSDK/GDTNativeExpressAdView.h>

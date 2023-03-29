//
//  WQNetworkReachabilityManager.h
//  BKApp
//
//  Created by 王孝旗 on 2022/8/25.
//  网络检测

#import <Foundation/Foundation.h>
#import "AFConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface WQNetworkReachabilityManager : NSObject

+ (WQNetworkReachabilityManager *)manager;

- (void)monitorNetworkStatus;

@property (nonatomic) AFNetworkReachabilityStatus networkStatus;

/// 检测是否有网络
@property (nonatomic, assign) BOOL isNetworkConnect;

/// 检测当前网络是否是WiFi
@property (nonatomic, assign) BOOL isWiFiConnect;


@end

NS_ASSUME_NONNULL_END

//
//  WQNetworkReachabilityManager.m
//  BKApp
//
//  Created by 王孝旗 on 2022/8/25.
//

#import "WQNetworkReachabilityManager.h"

@implementation WQNetworkReachabilityManager

static WQNetworkReachabilityManager *_manager = nil;

+ (WQNetworkReachabilityManager *)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super allocWithZone:NULL] init] ;
        //不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
        //已经重载allocWithZone基本的对象分配方法，所以要借用父类（NSObject）的功能来帮助出处理底层内存分配的杂物
    });
    return _manager;
}

//用alloc返回也是唯一实例
+ (id)allocWithZone:(struct _NSZone *)zone {
    return [WQNetworkReachabilityManager manager];
}

//对对象使用copy也是返回唯一实例
- (id)copyWithZone:(NSZone *)zone {
    return [WQNetworkReachabilityManager manager];
}

 //对对象使用mutablecopy也是返回唯一实例
- (id)mutableCopyWithZone:(NSZone *)zone {
    return [WQNetworkReachabilityManager manager];
}

- (void)monitorNetworkStatus {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"当前网络：未知");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"当前网络：蜂窝网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"当前网络：WIFI");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"当前网络：无网络");
                break;
                
            default:
                break;
        }
        if (self.networkStatus != status) {
            self.networkStatus = status;
            [[NSNotificationCenter defaultCenter] postNotificationName:kWQNetworkingReachabilityDidChange object:@(status)];
        }
    }];
    [manager startMonitoring];
}

- (BOOL)isNetworkConnect {
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

- (BOOL)isWiFiConnect {
    return [AFNetworkReachabilityManager sharedManager].isReachableViaWiFi;
}

@end

//
//  AFConfig.m
//  BKApp
//
//  Created by 王孝旗 on 2022/8/25.
//

#import "AFConfig.h"

NSString * const kResponseDataKey = @"data";
NSString * const kResponseMessageKey = @"message";
NSString * const kResponseCodeKey = @"statusCode";

NSString * const kWQNetworkingReachabilityDidChange = @"kWQNetworkingReachabilityDidChange";

@implementation AFConfig

static AFConfig *_config = nil;

// MARK: - 单例初始化

+ (AFConfig *)config {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = [[super allocWithZone:NULL] init] ;
        //不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
        //已经重载allocWithZone基本的对象分配方法，所以要借用父类（NSObject）的功能来帮助出处理底层内存分配的杂物
    });
    return _config;
}

//用alloc返回也是唯一实例
+ (id)allocWithZone:(struct _NSZone *)zone {
    return [AFConfig config];
}

//对对象使用copy也是返回唯一实例
- (id)copyWithZone:(NSZone *)zone {
    return [AFConfig config];
}

 //对对象使用mutablecopy也是返回唯一实例
- (id)mutableCopyWithZone:(NSZone *)zone {
    return [AFConfig config];
}

// MARK: - 

- (NSString *)afBaseURL {
    /*
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isLocalService = [userDefaults boolForKey:@"bk_isLocalServices"];
    if (isLocalService) {
        return @"http://b2600h0584.zicp.vip/api/";   // 娄俊本地;
    } else {
        return @"https://service.qmbokang.com/api/";    // 正式地址
    }*/
     return @"https://service.qmbokang.com/api/";    // 正式地址
//    return @"http://testlxz1627953975.qmbokang.com/api/"; // 测试地址;
//    return @"http://b2600h0584.zicp.vip/api/";   // 娄俊本地;
    
    // return @"http://39.103.176.173:8800/api/";   // 效祖本地;
    // return @"http://uk.qmbokang.com:8666/api/";
}

- (NSString *)imageBaseURL {
    return @"http://img.qmbokang.com/";
}

- (NSString *)shareBaseURL {
    return @"http://web.qmbokang.com/zydjk/";
}

- (NSTimeInterval)requestTimeOut {
    return 30.0f;
}

@end


@implementation ResponseModel

@end

@implementation BaseModel

@end

@implementation FormDataModel

@end

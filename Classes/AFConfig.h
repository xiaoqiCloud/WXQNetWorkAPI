//
//  AFConfig.h
//  BKApp
//
//  Created by 王孝旗 on 2022/8/25.
//  网络配置信息

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "WQAPI.h"


NS_ASSUME_NONNULL_BEGIN

#define kAFConfig  [AFConfig config]

typedef NS_ENUM(NSUInteger, NetworkResponseStatus) {
    /// 成功
    NetworkResponseStatusSuccess = 200,
    /// 身份过期
    NetworkResponseStatusBeOverdue = 40301,
    /// 无网络
    NetworkResponseStatusNotNetWork = 9999,
    /// 请求超时
    NetworkResponseStatusNetWorkTimeOut = -1001
};

UIKIT_EXTERN NSString * _Nullable const kResponseDataKey;
UIKIT_EXTERN NSString * _Nullable const kResponseMessageKey;
UIKIT_EXTERN NSString * _Nullable const kResponseCodeKey;
/// 网络变化通知
UIKIT_EXTERN NSString * _Nullable const kWQNetworkingReachabilityDidChange;

@interface AFConfig : NSObject

+ (AFConfig *)config;

// MARK: - 网络配置

/// BaseURL
@property (nonatomic, copy) NSString *afBaseURL;

/// 图片链接
@property (nonatomic, copy) NSString *imageBaseURL;

/// 分享链接
@property (nonatomic, copy) NSString *shareBaseURL;

/// 超时时间（单位：秒）默认：30s
@property (nonatomic, assign) NSTimeInterval requestTimeOut;


@end

@interface ResponseModel : NSObject

/// 请求状态码
@property (nonatomic, assign) NSInteger code;
/// 错误提示消息
@property (nonatomic, copy) NSString *message;
/// 返回的数据
@property (nonatomic, copy) id data;

@end

@interface BaseModel : NSObject

@end

// MARK: - 文件上传
@interface FormDataModel : NSObject

/// 要上传的文件
@property (nonatomic, copy) NSData *data;
/// 要上传的文件路径
@property (nonatomic, copy) NSString *filePath;
/// 服务器参数名称 后台给
@property (nonatomic, copy) NSString *name;
/// 文件名
@property (nonatomic, copy) NSString *fileName;
/// 文件类型 图片:image/jpg,image/png 视频:video/quicktime [mp3 : application/octer-stream application/octet-stream]
@property (nonatomic, copy) NSString *mimeType;

@end



NS_ASSUME_NONNULL_END

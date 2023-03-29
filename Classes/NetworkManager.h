//
//  NetworkManager.h
//  BKApp
//
//  Created by 王孝旗 on 2022/8/25.
//

#import <Foundation/Foundation.h>
#import "AFConfig.h"

NS_ASSUME_NONNULL_BEGIN

// 网络请求的回调 包括：网络请求的模型(code,message,data等，具体根据业务来定)
typedef void(^RequestCallback)(ResponseModel *responseModel);
// 单个模型的成功回调 包括： 模型，网络请求的模型(code,message,data等，具体根据业务来定)
typedef void(^RequestModelSuccessCallback)(BaseModel *model, ResponseModel *responseModel);
// 数组模型的成功回调 包括： 模型数组， 网络请求的模型(code,message,data等，具体根据业务来定)
typedef void(^RequestModelArraySuccessCallback)(NSArray <BaseModel *> *modelArray, ResponseModel *responseModel);
// 进度条
typedef void(^RequestProgressCallback)(NSProgress*);

@interface NetworkManager : NSObject


// MARK: - 网络请求

// MARK: GET

/// 基础GET请求
/// @param pathString 接口名
/// @param parameters 参数
/// @param needShowFailAlert 是否显示网络请求失败的弹框
/// @param successCallback 成功的回调
/// @param failCallback 失败的回调
+ (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)pathString parameters:(nullable id)parameters needShowFailAlert:(BOOL)needShowFailAlert successCallback:(RequestCallback)successCallback failCallback:(RequestCallback)failCallback;

+ (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)pathString parameters:(nullable id)parameters modelType:(nullable Class)modelType needShowFailAlert:(BOOL)needShowFailAlert modelSuccessCallback:(RequestModelSuccessCallback)successCallback failCallback:(RequestCallback)failCallback;

+ (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)pathString parameters:(nullable id)parameters modelType:(nullable Class)modelType needShowFailAlert:(BOOL)needShowFailAlert modelArraySuccessCallback:(RequestModelArraySuccessCallback)successCallback failCallback:(RequestCallback)failCallback;

// MARK: POST

/// 基础POST请求
/// @param pathString 接口名
/// @param parameters 参数
/// @param needShowFailAlert 是否显示网络请求失败的弹框
/// @param successCallback 成功的回调
/// @param failCallback 失败的回调
+ (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)pathString parameters:(nullable id)parameters needShowFailAlert:(BOOL)needShowFailAlert successCallback:(RequestCallback)successCallback failCallback:(RequestCallback)failCallback;

+ (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)pathString parameters:(nullable id)parameters modelType:(nullable Class)modelType needShowFailAlert:(BOOL)needShowFailAlert modelSuccessCallback:(RequestModelSuccessCallback)successCallback failCallback:(RequestCallback)failCallback;

+ (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)pathString parameters:(nullable id)parameters modelType:(nullable Class)modelType needShowFailAlert:(BOOL)needShowFailAlert modelArraySuccessCallback:(RequestModelArraySuccessCallback)successCallback failCallback:(RequestCallback)failCallback;

// MARK: - updata

+ (NSURLSessionDataTask *)UPDATA:(NSString *)pathString parameters:(nullable id)parameters formDatas:(NSArray <FormDataModel *> *)formDatas needShowFailAlert:(BOOL)needShowFailAlert progress:(RequestProgressCallback)progress successCallback:(RequestCallback)successCallback failCallback:(RequestCallback)failCallback;

@end

NS_ASSUME_NONNULL_END

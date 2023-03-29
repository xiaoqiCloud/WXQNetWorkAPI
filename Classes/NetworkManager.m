//
//  NetworkManager.m
//  BKApp
//
//  Created by 王孝旗 on 2022/8/25.
//

#import "NetworkManager.h"
#import "WQNetworkReachabilityManager.h"
#import "MJExtension.h"

@implementation NetworkManager

+ (AFSecurityPolicy *)customSecurityPolicy {
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    /*
     AFSSLPinningModeNone, 代表客户端无条件地信任服务器端返回的证书。
     AFSSLPinningModePublicKey,  代表客户端会将服务器端返回的证书与本地保存的证书中，PublicKey的部分进行校验；如果正确，才继续进行校验。
     AFSSLPinningModeCertificate,代表客户端会将服务器端返回的证书和本地保存的证书中的所有内容，包括PublicKey和证书部分，全部进行校验；如果正确，才继续进行
     */
        
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
     
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    return securityPolicy;
}

+ (AFHTTPSessionManager *)manager {
        
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:kAFConfig.afBaseURL]];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil];
    [manager.requestSerializer setTimeoutInterval:kAFConfig.requestTimeOut];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 证书配置
    //[manager setSecurityPolicy:[self customSecurityPolicy]];
    // 关闭缓存
    //manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    return manager;
}

// MARK: - headers

+ (NSDictionary *)headers {
    return @{
        @"Authorization" : @""
    };
}

// MARK: - 网络请求


// MARK: GET

+ (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)pathString parameters:(nullable id)parameters needShowFailAlert:(BOOL)needShowFailAlert successCallback:(RequestCallback)successCallback failCallback:(RequestCallback)failCallback {
    
    // 先判断网络是否有链接 没有的话直接返回--代码略
    if (![WQNetworkReachabilityManager manager].isNetworkConnect) {
        // code = 9999 代表无网络  这里根据具体业务来自定义
        [self errorHandler:NetworkResponseStatusNotNetWork message:@"您的网络似乎出现了问题，请检查网络" needShowFailAlert:needShowFailAlert failure:failCallback];
        return nil;
    }
    
    NSURLSessionDataTask *task;
    task = [[NetworkManager manager] GET:pathString parameters:parameters headers:[self headers] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        ResponseModel *respModel = [ResponseModel new];
        respModel.code = [[responseDictionary objectForKey:kResponseCodeKey] integerValue];
        respModel.message = [responseDictionary objectForKey:kResponseMessageKey];
        
        if (respModel.code == NetworkResponseStatusSuccess) {
            // 正确
            respModel.data = [responseDictionary objectForKey:kResponseDataKey];
            successCallback(respModel);
        } else {
            [self errorHandler:respModel.code message:respModel.message needShowFailAlert:needShowFailAlert failure:failCallback];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self errorHandler:error.code message:error.localizedDescription needShowFailAlert:needShowFailAlert failure:failCallback];
    }];
    return task;
}

+ (NSURLSessionDataTask *)GET:(nonnull NSString *)pathString parameters:(nullable id)parameters modelType:(nullable Class)modelType needShowFailAlert:(BOOL)needShowFailAlert modelSuccessCallback:(RequestModelSuccessCallback)successCallback failCallback:(RequestCallback)failCallback {
    return [self GET:pathString parameters:parameters needShowFailAlert:needShowFailAlert successCallback:^(ResponseModel * _Nonnull responseModel) {
        successCallback([modelType mj_objectWithKeyValues:responseModel.data], responseModel);
    } failCallback:failCallback];
}

+ (NSURLSessionDataTask *)GET:(nonnull NSString *)pathString parameters:(nullable id)parameters modelType:(nullable Class)modelType needShowFailAlert:(BOOL)needShowFailAlert modelArraySuccessCallback:(RequestModelArraySuccessCallback)successCallback failCallback:(RequestCallback)failCallback {
    return [self GET:pathString parameters:parameters needShowFailAlert:needShowFailAlert successCallback:^(ResponseModel * _Nonnull responseModel) {
        successCallback([modelType mj_objectArrayWithKeyValuesArray:responseModel.data], responseModel);
    } failCallback:failCallback];
}


// MARK: POST

+ (NSURLSessionDataTask *)POST:(nonnull NSString *)pathString parameters:(nullable id)parameters needShowFailAlert:(BOOL)needShowFailAlert successCallback:(RequestCallback)successCallback failCallback:(RequestCallback)failCallback {
        
    // 先判断网络是否有链接 没有的话直接返回--代码略
    if (![WQNetworkReachabilityManager manager].isNetworkConnect) {
        // code = 9999 代表无网络  这里根据具体业务来自定义
        [self errorHandler:NetworkResponseStatusNotNetWork message:@"您的网络似乎出现了问题，请检查网络" needShowFailAlert:needShowFailAlert failure:failCallback];
        return nil;
    }
    
    NSLog(@"=== %@\n%@",pathString, parameters);
    
    NSURLSessionDataTask *task;
    task = [[NetworkManager manager] POST:pathString parameters:parameters headers:[self headers] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        ResponseModel *respModel = [ResponseModel new];
        respModel.code = [[responseDictionary objectForKey:kResponseCodeKey] integerValue];
        respModel.message = [responseDictionary objectForKey:kResponseMessageKey];
        if (respModel.code == NetworkResponseStatusSuccess) {
            // 正确
            respModel.data = [responseDictionary objectForKey:kResponseDataKey];
            successCallback(respModel);
        } else {
            // 错误
            [self errorHandler:respModel.code message:respModel.message needShowFailAlert:needShowFailAlert failure:failCallback];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self errorHandler:error.code message:error.localizedDescription needShowFailAlert:needShowFailAlert failure:failCallback];
    }];
    return task;
}

+ (NSURLSessionDataTask *)POST:(nonnull NSString *)pathString parameters:(nullable id)parameters modelType:(nullable Class)modelType needShowFailAlert:(BOOL)needShowFailAlert modelSuccessCallback:(RequestModelSuccessCallback)successCallback failCallback:(RequestCallback)failCallback {
    return [self POST:pathString parameters:parameters needShowFailAlert:needShowFailAlert successCallback:^(ResponseModel * _Nonnull responseModel) {
        successCallback([modelType mj_objectWithKeyValues:responseModel.data], responseModel);
    } failCallback:failCallback];
}

+ (NSURLSessionDataTask *)POST:(nonnull NSString *)pathString parameters:(nullable id)parameters modelType:(nullable Class)modelType needShowFailAlert:(BOOL)needShowFailAlert modelArraySuccessCallback:(RequestModelArraySuccessCallback)successCallback failCallback:(RequestCallback)failCallback {
    return [self POST:pathString parameters:parameters needShowFailAlert:needShowFailAlert successCallback:^(ResponseModel * _Nonnull responseModel) {
        successCallback([modelType mj_objectArrayWithKeyValuesArray:responseModel.data], responseModel);
    } failCallback:failCallback];
}

// MARK: updata

+ (NSURLSessionDataTask *)UPDATA:(NSString *)pathString parameters:(nullable id)parameters formDatas:(NSArray <FormDataModel *> *)formDatas needShowFailAlert:(BOOL)needShowFailAlert progress:(RequestProgressCallback)progress successCallback:(RequestCallback)successCallback failCallback:(RequestCallback)failCallback {
    // 先判断网络是否有链接 没有的话直接返回--代码略
    if (![WQNetworkReachabilityManager manager].isNetworkConnect) {
        // code = 9999 代表无网络  这里根据具体业务来自定义
        [self errorHandler:NetworkResponseStatusNotNetWork message:@"您的网络似乎出现了问题，请检查网络" needShowFailAlert:needShowFailAlert failure:failCallback];
        return nil;
    }
    NSURLSessionDataTask *task;
    task = [[NetworkManager manager] POST:pathString parameters:parameters headers:[self headers] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (FormDataModel *model in formDatas) {
            if (model.data) {
                [formData appendPartWithFileData:model.data name:model.name fileName:model.fileName mimeType:model.mimeType];
            } else {
                [formData appendPartWithFileURL:[NSURL URLWithString:model.filePath] name:model.name fileName:model.fileName mimeType:model.mimeType error:nil];
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        ResponseModel *respModel = [ResponseModel new];
        respModel.code = [[responseDictionary objectForKey:kResponseCodeKey] integerValue];
        respModel.message = [responseDictionary objectForKey:kResponseMessageKey];
        
        if (respModel.code == NetworkResponseStatusSuccess) {
            // 正确
            respModel.data = [responseDictionary objectForKey:kResponseDataKey];
            successCallback(respModel);
        } else {
            // 错误
            [self errorHandler:respModel.code message:respModel.message needShowFailAlert:needShowFailAlert failure:failCallback];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self errorHandler:error.code message:@"网络连接失败" needShowFailAlert:needShowFailAlert failure:failCallback];
    }];
    return task;
}

// MARK: - 错误处理

+ (void)errorHandler:(NSInteger)code message:(NSString *)message needShowFailAlert:(BOOL)needShowFailAlert failure:(RequestCallback)failure {
    
    ResponseModel *model = [ResponseModel new];
    model.code = code;
    model.message = message;
    if (needShowFailAlert) {
        // 弹框
        //[SVProgressHUD dl_displayPrompt:message];
    }
    if (code == NetworkResponseStatusBeOverdue) {
        // 身份过期
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"KGoLoginControllerNotify" object:nil];
    }
    
    if (failure) {
        failure(model);
    }
}

@end

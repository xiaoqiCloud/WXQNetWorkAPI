//
//  WQAPI.m
//  BKApp
//
//  Created by 王孝旗 on 2022/8/25.
//

#import "WQAPI.h"

@implementation WQAPI

static WQAPI *_api = nil;

+ (WQAPI *)api {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _api = [[super allocWithZone:NULL] init] ;
        //不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
        //已经重载allocWithZone基本的对象分配方法，所以要借用父类（NSObject）的功能来帮助出处理底层内存分配的杂物
    });
    return _api;
}

//用alloc返回也是唯一实例
+ (id)allocWithZone:(struct _NSZone *)zone {
    return [WQAPI api] ;
}

//对对象使用copy也是返回唯一实例
- (id)copyWithZone:(NSZone *)zone {
    
    return [WQAPI api] ;
}

 //对对象使用mutablecopy也是返回唯一实例
- (id)mutableCopyWithZone:(NSZone *)zone {
    return [WQAPI api] ;
}

- (NSString *)wechatLoginByCode {
    return @"admin/m/third_party/wechatLoginByCode";
}

- (NSString *)userBindMoble {
    return @"admin/m/user/bindMobile";
}

- (NSString *)personalCenter {
    return @"admin/m/user/getPersonalCenter";
}

- (NSString *)orderList {
    return @"order/m/order/list";
}

- (NSString *)shopCartDel {
    return @"order/m/cart/del";
}

- (NSString *)uploadLocal {
    return @"files/bkUpload/uploadLocal";
}

- (NSString *)addUserComments {
    return @"admin/m/userComments/addUserComments";
}

- (NSString *)updateComments {
    return @"order/m/order/updateComments";
}

- (NSString *)commentsListById {
    return @"admin/m/userComments/queryCommentsListById";
}

- (NSString *)myTicketVideo {
    return @"admin/m/expertCenter/myTicketVideo";
}

- (NSString *)bkShopGoodsClass {
    return @"shop/m/bkShopGoodsClass/allClass";
}

- (NSString *)bkShopGoodsList {
    return @"shop/m/bkShopGood/goodsList";
}

- (NSString *)getMyZans {
    return @"admin/m/user/getMyZans";
}

- (NSString *)getMyComments {
    return @"admin/m/user/getMyComments";
}

- (NSString *)getMyLikesOrShare {
    return @"admin/m/user/getMyLikesOrShare";
}

- (NSString *)getVideoClass {
    return @"video/m/videoManager/getVideoClass";
}

// MARK: - 直播

- (NSString *)liveForecast {
    return @"live/m/liveInfo/forecast";
}

// MARK: - 圈子

- (NSString *)findCircle {
    return @"circle/m/circle/findCircle";
}

- (NSString *)searchLabelPage {
    return @"circle/m/circle/searchLabelPage";
}

- (NSString *)addUserZan {
    return @"admin/m/userZan/addUserZan";
}

- (NSString *)addUserLike {
    return @"admin/m/userLike/addUserLike";
}

- (NSString *)addUserShare {
    return @"admin/m/userShare/addUserShare";
}

- (NSString *)addDynamicAttention {
    return @"circle/m/dynamic/attention";
}

- (NSString *)uploadCommonImgMore {
    return @"files/bkUpload/uploadCommonImgMore";
}

- (NSString *)closeRecommendInfo {
    return @"circle/m/circle/closeRecommendInfo";
}

// MARK: - 科普大赛

- (NSString *)queryCompetitionList {
    return @"admin/m/competition/queryCompetitionList";
}

- (NSString *)queryCompDynamicListByPage {
    return @"admin/m/competition/queryCompDynamicListByPage";
}

- (NSString *)queryCompDynamDetail {
    return @"admin/m/competition/queryCompDynamDetail";
}

- (NSString *)addCompDynamic {
    return @"admin/m/competition/addCompDynamic";
}

- (NSString *)queryCompSession {
    return @"admin/m/competition/queryCompSession";
}

- (NSString *)acvitityVideoList {
    return @"video/m/videoInfo/acvitityVideoList";
}

- (NSString *)liveActivityList {
    return @"live/m/liveInfo/liveActivityList";
}

- (NSString *)getHomePageInfo {
    return @"admin/m/homePage/getHomePageInfo";
}

- (NSString *)getRecommendList {
    return @"admin/m/homePage/getRecommendList";
}

// MARK: - 群管理

- (NSString *)addGroupAdmin {
    return @"live/m/liveSet/addManager";
}

- (NSString *)removeGroupAdmin {
    return @"live/m/liveSet/delManager";
}

- (NSString *)listGroupAdmins {
    return @"live/m/liveSet/managerList";
}

- (NSString *)addKick {
    return @"live/m/liveManager/addKick";
}

- (NSString *)removeKick {
    return @"live/m/liveManager/removeKick";
}

- (NSString *)kickList {
    return @"live/m/liveManager/kickList";
}

- (NSString *)addShut {
    return @"live/m/liveManager/addShut";
}

- (NSString *)removeShut {
    return @"live/m/liveManager/removeShut";
}

- (NSString *)shutList {
    return @"live/m/liveManager/shutList";
}

// MARK: - 个人中心

- (NSString *)personIntroduceTop {
    return @"circle/m/circle/personIntroduceTop";
}

- (NSString *)personIntroduceLowerPart {
    return @"circle/m/circle/personIntroduceLowerPart";
}

@end

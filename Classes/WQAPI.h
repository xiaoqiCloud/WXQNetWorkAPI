//
//  WQAPI.h
//  BKApp
//
//  Created by 王孝旗 on 2022/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kAPI [WQAPI api]

@interface WQAPI : NSObject

+ (WQAPI *)api;

/// 微信登录
@property (nonatomic, copy) NSString *wechatLoginByCode;

/// 第三方登录绑定手机号
@property (nonatomic, copy) NSString *userBindMoble;

/// 个人中心
@property (nonatomic, copy) NSString *personalCenter;

/// 订单列表
@property (nonatomic, copy) NSString *orderList;

/// 删除购物车
@property (nonatomic, copy) NSString *shopCartDel;

/// 上传图片
@property (nonatomic, copy) NSString *uploadLocal;

/// 添加评论
@property (nonatomic, copy) NSString *addUserComments;

/// 更新评论状态
@property (nonatomic, copy) NSString *updateComments;

/// 添加列表
@property (nonatomic, copy) NSString *commentsListById;

/// 映票收入 视频或直播映票
@property (nonatomic, copy) NSString *myTicketVideo;

/// 商城分类
@property (nonatomic, copy) NSString *bkShopGoodsClass;

/// 商品列表
@property (nonatomic, copy) NSString *bkShopGoodsList;

/// 我的点赞
@property (nonatomic, copy) NSString *getMyZans;

/// 我的评论
@property (nonatomic, copy) NSString *getMyComments;

/// 我的转发或评论
@property (nonatomic, copy) NSString *getMyLikesOrShare;

/// 视频分类
@property (nonatomic, copy) NSString *getVideoClass;

// MARK: - 直播

/// 直播预告
@property (nonatomic, copy) NSString *liveForecast;


// MARK: - 圈子

/// 圈子发现
@property (nonatomic, copy) NSString *findCircle;

/// 热门话题
@property (nonatomic, copy) NSString *searchLabelPage;

/// 点赞
@property (nonatomic, copy) NSString *addUserZan;

/// 收藏
@property (nonatomic, copy) NSString *addUserLike;

/// 分享
@property (nonatomic, copy) NSString *addUserShare;

/// 关注
@property (nonatomic, copy) NSString *addDynamicAttention;

/// 发布圈子
@property (nonatomic, copy) NSString *uploadCommonImgMore;
/// 帖子详情
//@property (nonatomic, copy) NSString *circleQueryReleaseDetail;

/// 发现中关闭个别推荐(id:帖子id)
@property (nonatomic, copy) NSString *closeRecommendInfo;

// MARK: - 科普大赛

/// 查询大赛记录
@property (nonatomic, copy) NSString *queryCompetitionList;

/// 查询大赛科普文章列表
@property (nonatomic, copy) NSString *queryCompDynamicListByPage;

/// 查询大赛科普文章详情
@property (nonatomic, copy) NSString *queryCompDynamDetail;

/// 大赛科普文章报名
@property (nonatomic, copy) NSString *addCompDynamic;

/// 查询大赛往届数据
@property (nonatomic, copy) NSString *queryCompSession;

/// 科普大赛视频列表
@property (nonatomic, copy) NSString *acvitityVideoList;

/// 直播列表
@property (nonatomic, copy) NSString *liveActivityList;

/// 首页
@property (nonatomic, copy) NSString *getHomePageInfo;
/// 获取首页推荐医生列表
@property (nonatomic, copy) NSString *getRecommendList;


// MARK: - 群管理

/// 升级群成员为群管理员
@property (nonatomic, copy) NSString *addGroupAdmin;
/// 降级群管理员为群成员
@property (nonatomic, copy) NSString *removeGroupAdmin;
/// 获取群全部管理员
@property (nonatomic, copy) NSString *listGroupAdmins;
/// 拉黑踢人 直接踢出直播间 此主播的所有直播不可以进入
@property (nonatomic, copy) NSString *addKick;
/// 解除拉黑
@property (nonatomic, copy) NSString *removeKick;
/// 拉黑观众列表
@property (nonatomic, copy) NSString *kickList;
/// 禁言 本场直播可看不可说
@property (nonatomic, copy) NSString *addShut;
/// 解除禁言
@property (nonatomic, copy) NSString *removeShut;
/// 禁言观众列表
@property (nonatomic, copy) NSString *shutList;

// MARK: - 个人中心

/// 个人主页
@property (nonatomic, copy) NSString *personIntroduceTop;
/// 个人内容
@property (nonatomic, copy) NSString *personIntroduceLowerPart;

@end

NS_ASSUME_NONNULL_END

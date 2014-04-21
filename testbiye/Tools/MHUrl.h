//
//  MHUrl.h
//  iBaby-iPhone
//
//  Created by jing jiang on 10/11/12.las
//  Copyright (c) 2012 imohoo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define _DEBUG

#ifdef _DEBUG
    #define  kBaseURL             @"http://192.168.0.203"
#else
    #define  kBaseURL             @"http://api.comm.578g.com"
#endif


#define  kHttpPostMethod    @"POST"
#define  kHttpGetMethod     @"GET"

#define kDefaultStartPage      0
#define kDefaultNumPerPage     20

typedef enum _OpeartionRequestTag {
    
    OpeartionRequestTagNone = 0,
    OpeartionRequestTagRegiste = 1,
    OpeartionRequestTagLogin = 2,
   
    OpeartionRequestTagGetContactsList,
    OpeartionRequestTagGetUserInfo,
    OpeartionRequestTagGetUserAlias,
    
    OpeartionRequestTagGetGroupBasic,
    
    OpeartionRequestTagUploadImage,
    OpeartionRequestTagUploadAudio,
    //完善用户信息
    OpeartionRequestTagPerfectUserInfo,

    //开启、关闭通知
    OpeartionRequestTagTurnOnOrOffPush,

    //获取群组信息(包含用户)
    OpeartionRequestTagGetGroupContainUsers,
    //修改密码
    OpeartionRequestTagChangeUserPassWord,
    //退出登录
    OpeartionRequestTagLogOut,
    
    
    /*业内说相关*/
    //业内说 列表
    OpeartionRequestTagCircleSaysList,
    //业内说 详情
    OpeartionRequestTagCircleSaysDetail,
    //业内说 评论列表
    OpeartionRequestTagCircleSaysCommentList,
    //业内说 评论
    OpeartionRequestTagCircleSaysComment,
    //业内说 私信
    OpeartionRequestTagCircleSaysPrivateLetterSend,
    //业内说 赞
    OpeartionRequestTagCircleSaysPraise,
    //业内说 取消赞
    OpeartionRequestTagCircleSaysCanclePraise,
    //业内说 转发
    OpeartionRequestTagCircleSaysTransmit,
    //业内说 发布我的业内说
    OpeartionRequestTagCircleSaysPublish,
    //业内说 删除我的业内说
    OpeartionRequestTagCircleSaysDelete,
    //业内说 获取某个人的业内说
    OpeartionRequestTagUserCircleSaysList,
    
    //发需求
    OpeartionRequestTagNeedsPublish,
    //需求 详情
    OpeartionRequestTagNeedsDetail,
    
}OpeartionRequestTag;
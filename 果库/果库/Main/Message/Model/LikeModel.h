//
//  LikeModel.h
//  果库
//
//  Created by apple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LikeModel : NSObject

@property (nonatomic, assign) NSNumber *following_count; //关注数
@property (nonatomic, copy) NSString *avatar_small; //用户头像
@property (nonatomic, copy) NSString *nick; //用户名
@property (nonatomic, assign) NSNumber *fan_count; //粉丝数

@property (nonatomic,strong) UIButton *button;

@end

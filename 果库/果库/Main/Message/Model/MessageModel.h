//
//  MessageModel.h
//  果库
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *created_time; //发送时间
@property (nonatomic, copy) NSString *type; //类型
@property (nonatomic, copy) NSString *nick; //用户名

@property (nonatomic, copy) NSString *avatar_small; //用户头像


@end

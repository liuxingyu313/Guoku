//
//  DynamicModel.h
//  果库
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DynamicModel : NSObject

@property (nonatomic, copy) NSString *created_time; //发送时间
@property (nonatomic, copy) NSString *avatar_small; //用户头像
@property (nonatomic, copy) NSString *nick; //用户名
@property (nonatomic, copy) NSString *type; //类型
@property (nonatomic, copy) NSString *chief_image; //商品图片





@property (nonatomic, strong) NSArray *detail_images; //商品图片组
@property (nonatomic, copy) NSString *price; //价格
@property (nonatomic, copy) NSString *title; //标题
@property (nonatomic, assign) NSNumber *like_count;

@property (nonatomic, copy) NSString *entity_id; //id


@end

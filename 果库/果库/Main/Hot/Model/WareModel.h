//
//  WareModel.h
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WareModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *post_time;
@property (nonatomic, copy) NSString *chief_image;
@property (nonatomic, copy) NSString *like_count;
@property (nonatomic, copy) NSString *like_already;

@property (nonatomic, strong) NSArray *detail_images;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *buy_link;

@property (nonatomic, copy) NSString *entity_id;





@end

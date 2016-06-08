//
//  CommondityModel.h
//  果库
//
//  Created by HZApple on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommondityModel : NSObject

@property (nonatomic, copy) NSString *chief_image;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *commodityTitle;

@property (nonatomic, copy) NSString *brand;

@property (nonatomic, strong) NSArray *detail_images;

@property (nonatomic, copy) NSNumber *like_count;

@property (nonatomic, copy) NSString *buy_link;

@end

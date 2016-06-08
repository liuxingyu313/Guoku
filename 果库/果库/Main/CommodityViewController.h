//
//  CommodityViewController.h
//  果库
//
//  Created by HZApple on 16/5/28.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommodityViewController : UIViewController

@property (nonatomic, copy) NSString *chief_image;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *commodityTitle;

@property (nonatomic, strong) NSArray *detail_images;

@property (nonatomic, copy) NSString *like_count;

@property (nonatomic, copy) NSString *buy_link;

@end

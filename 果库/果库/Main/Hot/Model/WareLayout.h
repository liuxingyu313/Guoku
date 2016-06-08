//
//  WareLayout.h
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WareModel.h"

@interface WareLayout : NSObject

@property (nonatomic, strong) WareModel *model;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat contentHeight;

@end

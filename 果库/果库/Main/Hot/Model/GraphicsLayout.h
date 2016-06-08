//
//  GraphicsLayout.h
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphicsModel.h"

@interface GraphicsLayout : NSObject

@property (nonatomic, strong) GraphicsModel *model;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat titleHeight;

@end

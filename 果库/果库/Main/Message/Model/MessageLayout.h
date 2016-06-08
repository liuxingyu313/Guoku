//
//  MessageLayout.h
//  果库
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@interface MessageLayout : NSObject

@property (nonatomic, strong) MessageModel *model;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat contentHeight;

@end

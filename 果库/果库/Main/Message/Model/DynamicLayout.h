//
//  DynamicLayout.h
//  果库
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynamicModel.h"

@interface DynamicLayout : NSObject

@property (nonatomic, strong) DynamicModel *model;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat contentHeight;


@end

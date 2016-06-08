//
//  AuthorizeduserUserModel.h
//  果库
//
//  Created by HZApple on 16/5/30.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorizeduserUserModel : NSObject

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *avatar_small;

@property (nonatomic, copy) NSString *bio;

@property (nonatomic, strong)  NSNumber *fan_count;

@property (nonatomic, strong) NSNumber *like_count;

@end

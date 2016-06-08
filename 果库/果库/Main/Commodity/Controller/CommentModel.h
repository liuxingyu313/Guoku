//
//  CommentModel.h
//  果库
//
//  Created by HZApple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic, copy) NSString *avatar_small;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *postTime;

@property (nonatomic, copy) NSNumber *poke_count;

@property (nonatomic, copy) NSNumber *comment_count;

@property (nonatomic, assign) CGFloat cellHeight;

- (CGFloat)countCellHeight;

@end

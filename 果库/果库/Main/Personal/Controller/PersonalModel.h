//
//  PersonalModel.h
//  果库
//
//  Created by HZApple on 16/6/2.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalModel : NSObject

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *avatar_small;

@property (nonatomic, strong)  NSNumber *fan_count;

@property (nonatomic, strong) NSNumber *like_count;

@property (nonatomic, strong) NSNumber *entity_note_count;

@property (nonatomic, strong) NSNumber *following_count;

@property (nonatomic, strong) NSNumber *dig_count;

@property (nonatomic, strong) NSNumber *tag_count;

@property (nonatomic, strong) NSMutableArray *chief_imageArray;

@end

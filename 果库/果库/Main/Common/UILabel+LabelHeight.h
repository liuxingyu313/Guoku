//
//  UILabel+LabelHeight.h
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelHeight)

+ (CGFloat)getTextHeightWithFontSize:(NSInteger)font width:(CGFloat)width text:(NSString *)text;

- (CGFloat)getTextHeightWithFontSize:(NSInteger)font width:(CGFloat)width text:(NSString *)text;
@end

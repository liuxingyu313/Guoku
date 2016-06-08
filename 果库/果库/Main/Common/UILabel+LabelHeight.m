//
//  UILabel+LabelHeight.m
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "UILabel+LabelHeight.h"

@implementation UILabel (LabelHeight)

+ (CGFloat)getTextHeightWithFontSize:(NSInteger)font width:(CGFloat)width text:(NSString *)text {
    
    UIFont *font1 = [UIFont systemFontOfSize:font];
    
    CGRect tmpRect = [text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font1,NSFontAttributeName ,nil] context:nil];
    
    return tmpRect.size.height;
  
}

- (CGFloat)getTextHeightWithFontSize:(NSInteger)font width:(CGFloat)width text:(NSString *)text {
   return  [[self class] getTextHeightWithFontSize:font width:width text:text];
}

@end

//
//  CommentModel.m
//  果库
//
//  Created by HZApple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CommentModel.h"
#import "UILabel+LabelHeight.h"

@implementation CommentModel

- (CGFloat)countCellHeight {
    CGFloat height = 0;
    
    height += 87 ;
    
    height += [UILabel getTextHeightWithFontSize:14 width:kScreenWidth - 60 text:_content];
    
    return height;
}

@end

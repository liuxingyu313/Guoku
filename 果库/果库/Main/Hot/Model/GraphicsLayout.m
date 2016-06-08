
//
//  GraphicsLayout.m
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "GraphicsLayout.h"

@implementation GraphicsLayout

- (void)setModel:(GraphicsModel *)model {
    _model = model;
    
    self.titleHeight = [UILabel getTextHeightWithFontSize:16 width:kScreenWidth - 20 text:_model.title];
    
    self.cellHeight = kScreenHeight / 3 + 42 + self.titleHeight + 40 + 40;
    
}



@end

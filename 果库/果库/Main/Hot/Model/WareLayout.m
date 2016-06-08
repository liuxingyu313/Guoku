

//
//  WareLayout.m
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "WareLayout.h"

@implementation WareLayout

- (void)setModel:(WareModel *)model {
    _model = model;
    
    self.contentHeight = [UILabel getTextHeightWithFontSize:15 width:kScreenWidth - 20 text:_model.content];
    if (self.contentHeight > 55) {
        self.contentHeight = 55;
    }
    
    self.cellHeight = self.contentHeight + kScreenWidth + 40;
    
}

@end

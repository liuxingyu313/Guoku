//
//  GraphicsTableViewCell.m
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "GraphicsTableViewCell.h"
#import "NSString+TimeAgo.h"
#import "UIImageView+WebCache.h"
#import "HotViewController.h"
#import "WebViewController.h"


@implementation GraphicsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (UIImageView *)mainImageView {
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, kScreenHeight / 3)];
        [self addSubview:_mainImageView];
    }
    return _mainImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil ) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,_mainImageView.bottom + 20, kScreenWidth - 20, 30)];
        _titleLabel.font = k15Font;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _titleLabel.bottom  , kScreenWidth - 20, 40)];
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = k14Font;
        _contentLabel.textColor = [UIColor grayColor];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 60,_titleLabel.bottom + 10, 60, 20)];
        _timeLabel.font = k12Font;
        _timeLabel.textColor = [UIColor grayColor];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (void)setLayout:(GraphicsLayout *)layout {
    _layout = layout;
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", GuoKuWebImage, _layout.model.cover]]];
    self.titleLabel.text = _layout.model.title;
    self.titleLabel.height = _layout.titleHeight;
    self.contentLabel.text = [NSString stringWithFormat:@"%@...",_layout.model.digest]  ;
    self.timeLabel.text = [NSString TimeAgo:_layout.model.pub_time];
    self.timeLabel.frame = CGRectMake(kScreenWidth - 60, _contentLabel.bottom + 10, 60, 20);
    
}



//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self _createSubview];
//    }
//    return self;
//    
//}
//
//- (void)_createSubview {
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:_mainImageView];
    BOOL isinside = [_mainImageView pointInside:location withEvent:event];
    if (isinside) {
        UITableView *tableview = (UITableView *)self.nextResponder.nextResponder;
        
        UIView * view = tableview.superview.superview;
        
        HotViewController *hot = (HotViewController *)view.nextResponder;
        hot.hidesBottomBarWhenPushed = YES;
        WebViewController *webView = [[WebViewController alloc] init];
        webView.url = _layout.model.url;
        
        [hot.navigationController pushViewController:webView animated:YES];
        hot.hidesBottomBarWhenPushed = NO;
        
    }
}

@end

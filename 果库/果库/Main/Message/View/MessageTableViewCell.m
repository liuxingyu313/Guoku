//
//  MessageTableViewCell.m
//  果库
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+TimeAgo.h"
#import "UIView+UIViewController.h"
#import "BasePersonalViewController.h"

@implementation MessageTableViewCell

- (UIImageView *)userImgView {
    if (_userImgView == nil) {
        _userImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self.contentView addSubview:_userImgView];
    }
    return _userImgView;
}

- (UILabel *)userLabel {
    if (_userLabel == nil) {
        _userLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 0, 20)];
        [self.contentView addSubview:_userLabel];
    }
    return _userLabel;
    
}

- (UILabel *)typeLabel {
    if (_typeLabel == nil) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userLabel.right, 10, 0, 20)];
        [self.contentView addSubview:_typeLabel];
    }
    return _typeLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_typeLabel.right, 10, 0, 20)];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (void)setLayout:(MessageLayout *)layout {
    
    _layout = layout;
    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:_layout.model.avatar_small]];
    self.userImgView.layer.cornerRadius = 20;
    self.userImgView.layer.masksToBounds = YES;
    self.userLabel.textColor = [UIColor blueColor];
    self.userLabel.text = _layout.model.nick;
    [self.userLabel sizeToFit];
    if ([_layout.model.type isEqualToString:@"user_follow"]) {
        self.typeLabel.text = @"关注了你";
    }
    
    [self.typeLabel sizeToFit];
    self.typeLabel.left = self.userLabel.right;
    
    self.timeLabel.text = _layout.model.created_time;
    
    self.timeLabel.textColor = [UIColor lightGrayColor];
    [self.timeLabel sizeToFit];
    self.timeLabel.left = self.typeLabel.right;
 
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:_userImgView];
    CGPoint location1 = [touch locationInView:_userLabel];
    
    if ([_userImgView pointInside:location withEvent:event] || [_userLabel pointInside:location1 withEvent:event]) {
        
        BasePersonalViewController *viewcontroller = (BasePersonalViewController *)[self ViewController];
        
        viewcontroller.hidesBottomBarWhenPushed = YES;
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
        
        BasePersonalViewController *base = [storyBoard instantiateViewControllerWithIdentifier:@"Personal"];
        base.url = @"http://api.guoku.com/mobile/v4/user/130749/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&session=138b8a1faca3b55e9ece6f14b83bcfc6&sign=b9f9119e711fa50715694cd863c0bcbe";
        base.isNotSelf = YES;
        
        [viewcontroller.navigationController pushViewController:base animated:NO];
        
        viewcontroller.hidesBottomBarWhenPushed = NO;
        
        
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

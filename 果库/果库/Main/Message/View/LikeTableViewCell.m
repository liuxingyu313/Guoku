//
//  LikeTableViewCell.m
//  果库
//
//  Created by apple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "LikeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PersonalProfileViewController.h"
#import "UIView+UIViewController.h"
#import "LikeTableViewController.h"



@implementation LikeTableViewCell

- (UIImageView *)userImgView {
    if (_userImgView == nil) {
        _userImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self.contentView addSubview:_userImgView];
    }
    return _userImgView;
}

- (UILabel *)userLabel {
    if (_userLabel == nil) {
        _userLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 0, 20)];
        [self.contentView addSubview:_userLabel];
    }
    return _userLabel;
    
}

- (UILabel *)followLabel {
    if (_followLabel == nil) {
        _followLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, 20, 20)];
        [self.contentView addSubview:_followLabel];
    }
    return _followLabel;
}

- (UILabel *)fanLabel {
    if (_fanLabel == nil) {
        _fanLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 35, 5, 20)];
        [self.contentView addSubview:_fanLabel];
    }
    return _fanLabel;
}

- (UIButton *)followButton {
    if (_followButton == nil) {
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _followButton.frame = CGRectMake(kScreenWidth - 60, 15, 30, 30);
        [self.contentView addSubview:_followButton];
    }
    return _followButton;
    
}

- (void)setModel:(LikeModel *)model {
    _model = model;
    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:model.avatar_small]];
    self.userImgView.layer.cornerRadius = 20;

    self.userLabel.text = model.nick;
    [self.userLabel sizeToFit];
    
    self.followLabel.text = [NSString stringWithFormat:@"关注 %li",[model.following_count integerValue]];
    [self.followLabel sizeToFit];
    
    self.fanLabel.text = [NSString stringWithFormat:@"粉丝 %li",[model.fan_count integerValue]];
    [self.fanLabel sizeToFit];

    [self.followButton setBackgroundImage:[UIImage imageNamed:@"timeline_relationship_icon_addattention@2x"] forState:UIControlStateNormal];
    [self.followButton setBackgroundImage:[UIImage imageNamed:@"timeline_relationship_icon_attention@2x"] forState:UIControlStateSelected];
    [self.followButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark buttonAction
- (void)buttonAction {
    LikeTableViewController *control = (LikeTableViewController *)[self ViewController];
  
    control.hidesBottomBarWhenPushed = YES;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PersonalProfile" bundle:nil];
    PersonalProfileViewController *personal = [storyboard instantiateViewControllerWithIdentifier:@"11"];
    
    [control.navigationController pushViewController:personal animated:YES];
    control.hidesBottomBarWhenPushed = NO;
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

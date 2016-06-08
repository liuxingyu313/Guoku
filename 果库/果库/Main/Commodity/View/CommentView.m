//
//  CommentView.m
//  果库
//
//  Created by HZApple on 16/5/29.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CommentView.h"
#import "UIButton+WebCache.h"
#import "UILabel+LabelHeight.h"

@interface CommentView () {
    
    UIView *_praiseView;
    
    UIView *_commentView;
    
}
@end



@implementation CommentView

- (UIButton *)iconButton {
    if (_iconButton == nil) {
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconButton.frame = CGRectMake(10, 5, kScreenWidth / 10, kScreenWidth / 10);
        _iconButton.layer.cornerRadius = kScreenWidth / 20;
        _iconButton.layer.masksToBounds = YES;
        [self addSubview:_iconButton];
    }
    return _iconButton;
}


- (void)_loadNickButton {
    if (_nickButton == nil) {
        _nickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nickButton.frame = CGRectMake(_iconButton.right + 10, 15, 100, 20);
        [_nickButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:_nickButton];
    }
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconButton.right + 10, _nickButton.bottom + 12, kScreenWidth - 60, 100)];
        _contentLabel.font = k14Font;
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
    }
    return  _contentLabel;
}

- (UILabel *)pariseLabel {
    if (_pariseLabel == nil) {
        _pariseLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 40, 20)];
        [_praiseView addSubview:_pariseLabel];
    }
    return _pariseLabel;
}

- (UILabel *)commentLabel {
    if (_commentLabel == nil) {
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 40, 20)];
        [_commentView addSubview:_commentLabel];
    }
    return _commentLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 100, _contentLabel.bottom + 10, 100, 20)];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (void)_loadPariseView {
    if (_praiseView == nil) {
        _praiseView = [[UIView alloc] initWithFrame:CGRectMake(_contentLabel.left, _contentLabel.bottom + 10, 60, 20)];
        [self addSubview:_praiseView];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 20, 20);
        [button setBackgroundColor:[UIColor cyanColor]];
        [_praiseView addSubview:button];
    }
    
}
- (void)_loadCommentView {
    if (_commentView == nil) {
        _commentView = [[UIView alloc] initWithFrame:CGRectMake(_praiseView.right + 20, _contentLabel.bottom + 10, 60, 20)];
        [self addSubview:_commentView];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 20, 20);
        [button setBackgroundColor:[UIColor cyanColor]];
        [_commentView addSubview:button];
    }
    
}


- (void)setModel:(CommentModel *)model {
    _model = model;
    
    [self.iconButton sd_setImageWithURL:[NSURL URLWithString:_model.avatar_small] forState:UIControlStateNormal];
    [self _loadNickButton];
    [self.nickButton setTitle:_model.nick forState:UIControlStateNormal];
    self.contentLabel.text = _model.content;
    _contentLabel.height = [_contentLabel getTextHeightWithFontSize:14 width:kScreenWidth - 60 text:_model.content];
    
    [self _loadPariseView];
    [self _loadCommentView];
    
    self.commentLabel.text = [NSString stringWithFormat:@"%@",_model.comment_count];
    self.pariseLabel.text = [NSString stringWithFormat:@"%@",_model.poke_count];
    self.timeLabel.text = _model.postTime;
    
    
}

@end

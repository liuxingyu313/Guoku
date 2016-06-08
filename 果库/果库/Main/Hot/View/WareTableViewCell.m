//
//  WareTableViewCell.m
//  果库
//
//  Created by HZApple on 16/5/25.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "WareTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "NSString+TimeAgo.h"
#import "HotViewController.h"
#import "CommodityViewController.h"

#define kWebLike @"http://api.guoku.com/mobile/v4/entity"

@implementation WareTableViewCell

- (void)awakeFromNib {

    // Initialization code
}

- (UIImageView *)pictureImageView {
    if (_pictureImageView == nil) {
        _pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, kScreenWidth - 40, kScreenWidth - 40)];
        [self addSubview:_pictureImageView];
    }
    return _pictureImageView;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,_pictureImageView.bottom + 10, kScreenWidth - 20 , 45)];
        _contentLabel.numberOfLines = 0;
        [_contentLabel setFont:k15Font];
        
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}



- (UIButton *)likeButton {
    if (_likeButton == nil) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.frame = CGRectMake(10, _contentLabel.bottom + 5, 30, 30);
        [_likeButton setImage:[UIImage imageNamed:@"playing_btn_in_myfavor"] forState:UIControlStateSelected];
        [_likeButton setImage:[UIImage imageNamed:@"playing_btn_in_myfavor_h"] forState:UIControlStateNormal];
        [_likeButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_likeButton];
    }
    return _likeButton;
}

- (UILabel *)likeCountLabel {
    if (_likeCountLabel == nil) {
        _likeCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, _contentLabel.bottom + 10, 40, 20)];
        _likeCountLabel.layer.cornerRadius = 3;
        _likeCountLabel.layer.masksToBounds = YES;
        _likeCountLabel.font = k14Font;
        _likeCountLabel.textAlignment = NSTextAlignmentCenter;
        _likeCountLabel.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
        [self addSubview:_likeCountLabel];
    }
    return _likeCountLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 80,_contentLabel.bottom + 10, 80, 20)];
        [_timeLabel setFont:k14Font];
        [_timeLabel setTextColor:[UIColor grayColor]];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (void)setLayout:(WareLayout *)layout {
//    
//    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//   
//    [_likeButton setImage:[UIImage imageNamed:@"playing_btn_in_myfavor"] forState:UIControlStateNormal];
//    [_likeButton setImage:[UIImage imageNamed:@"playing_btn_in_myfavor_h"] forState:UIControlStateHighlighted];
//    //[_likeButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _layout = layout;
    
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:_layout.model.chief_image]];
    self.contentLabel.text = _layout.model.content;
    self.contentLabel.height = _layout.contentHeight;
    
    
    if ([_layout.model.like_already isEqualToString:@"1"]) {
        self.likeButton.selected = YES;
    }else {
        self.likeButton.selected = NO;
    }
    
    _likeButton.frame = CGRectMake(10, _contentLabel.bottom + 5, 30, 30);
    _likeCountLabel.frame = CGRectMake(40, _contentLabel.bottom + 10, 40, 20);

    _timeLabel.frame= CGRectMake(kScreenWidth - 80,_contentLabel.bottom + 10, 80, 20);
    
    self.likeCountLabel.text = _layout.model.like_count;
    self.timeLabel.text = [NSString TimeAgo:_layout.model.post_time];
//    if (_contentLabel.bottom != 0) {
//          _likeButton.frame = CGRectMake(10, _contentLabel.bottom + 5 , 30, 30);
//        [self addSubview:_likeButton];
//    }
  
    
}

#pragma mark buttonAction
- (void)buttonAction{
    NSDictionary *dic = @{@"api_key":@"0b19c2b93687347e95c6b6f5cc91bb87",
                          @"session":@"138b8a1faca3b55e9ece6f14b83bcfc6",
                          @"sign":@"b9f9119e711fa50715694cd863c0bcbe"
                          };
    if (self.likeButton.selected) {
        NSString *string = [NSString stringWithFormat:@"%@/%@/like/0",kWebLike,_layout.model.entity_id];
        
      [[AFHTTPSessionManager manager] POST:string parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
          NSLog(@"success");
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           NSLog(@"%@",error);
      }];

    }else {
        NSString *string = [NSString stringWithFormat:@"%@/%@/like/1",kWebLike,_layout.model.entity_id];
        [[AFHTTPSessionManager manager] POST:string parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            NSLog(@"success");
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
   
    }
    _likeButton.selected = !_likeButton.selected;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:_pictureImageView];
    BOOL isinside = [_pictureImageView pointInside:location withEvent:event];
    if (isinside) {
        
        UITableView *tableview = (UITableView *)self.nextResponder.nextResponder;
        
        UIView * view = tableview.superview.superview;
        
        HotViewController *hot = (HotViewController *)view.nextResponder;
        
        hot.hidesBottomBarWhenPushed = YES;
        CommodityViewController *commodity = [[CommodityViewController alloc] init];
        
        commodity.chief_image = _layout.model.chief_image;
        commodity.commodityTitle = _layout.model.title;
        commodity.price = _layout.model.price;
        commodity.detail_images = _layout.model.detail_images;
        commodity.like_count =  [NSString stringWithFormat:@"%@",_layout.model.like_count ];
        commodity.buy_link = _layout.model.buy_link;
        
        [hot.navigationController pushViewController:commodity animated:YES];
        
        hot.hidesBottomBarWhenPushed = NO;
    }

}


//- (void)buttonAction {
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

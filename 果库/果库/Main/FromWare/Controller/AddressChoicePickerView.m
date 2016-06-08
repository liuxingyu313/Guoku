//
//  addressChoicePickerView.m
//  自做pickerView省市区
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "AddressChoicePickerView.h"
#import "AreaObject.h"
@interface AddressChoicePickerView () <UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *pn; //省名
    NSArray *cn; //城市名
    NSDictionary *dic1;
    NSDictionary *dic2;
    NSArray *array1;  //城市的数组
    NSArray *array2; //县区的数组
}


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHegithCons;

@property (strong,nonatomic) AreaObject *locate;

@end

@implementation AddressChoicePickerView

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"AddressChoicePickerView" owner:nil options:nil] firstObject];
        self.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
         NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Address.plist" ofType:nil]];
        
        dic1 = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Address.plist" ofType:nil]];
        
        self.backgroundColor = [UIColor clearColor];
        
        pn = [dic1 allKeys];
        array1 = dic[pn[0]];
        dic2 = array1[0];
        cn = [dic2 allKeys];
        array2 = dic2[cn[0]];
    
    }
    return self;
    
}

- (void)customView {
    self.contentViewHegithCons.constant = 0;
    [self layoutIfNeeded];
}

#pragma mark setter and getter
- (AreaObject *)locate {
    if (!_locate) {
        _locate = [[AreaObject alloc] init];
        
    }
    return _locate;
}

#pragma mark - buttonAction

//确认
- (IBAction)finishBtnPress:(UIButton *)sender {
    
    if (self.block) {
        self.block(self,sender,self.locate);
    }
    [self hide];
}

//隐藏
- (IBAction)dissmissBtnPress:(UIButton *)sender {
    
    [self hide];
    
}

#pragma mark function \

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = [window.subviews firstObject];
    [topView addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentViewHegithCons.constant = 250;
        [self layoutIfNeeded];
    }];
    
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0;
        self.contentViewHegithCons.constant = 0;
        [self layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

#pragma  mark -UIPickerViewDataSource
//返回总共有几列

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

//返回指定列有几行

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return pn.count;
            break;
        case 1:
            return cn.count;
            break;
        case 2:
            return array2.count;
            break;
            
        default:
            return 0;
            break;
    }
}

//标准的UIPickerView内容，只有字符串
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [pn objectAtIndex:row];
            break;
        case 1:
            return [cn  objectAtIndex:row];
            break;
        case 2:
                
            return [array2 objectAtIndex:row];
            break;
            
            
        default:
            return @"";
            break;
    }
}

#pragma mark-UIPickerViewDelegate 
//自定义的UIPickerView内容，给每列每行设置一个UIView
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;//设置最小收缩比例
        pickerLabel.adjustsFontSizeToFitWidth = YES;//改变字母之间的间距来适应Label大小
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

//已经选择了点击
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
            
        case 0:
            array1 = dic1[pn[row]];
            dic2 = array1[0];
            cn = [dic2 allKeys];
            
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            
            array2 = dic2[cn[0]];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        
            
            self.locate.province = pn[row];
            self.locate.city = cn[0];
            self.locate.area = array2[0];
            
            break;
            
        case 1:
            array2 = dic2[cn[row]];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            
            self.locate.city = cn[row];
            self.locate.area = array2[0];
       
            break;

        case 2:
            self.locate.area = array2[row];

            break;
            
        default:
            break;
    }
}














@end

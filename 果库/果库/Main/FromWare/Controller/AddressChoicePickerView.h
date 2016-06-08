//
//  addressChoicePickerView.h
//  自做pickerView省市区
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaObject.h"

@class AddressChoicePickerView;


typedef void(^AddressChoicePickerViewBlock)(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate);

@interface AddressChoicePickerView : UIView
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (copy,nonatomic) AddressChoicePickerViewBlock block;

- (void)show;

@end

//
//  AreaObject.m
//  自做pickerView省市区
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "AreaObject.h"

@implementation AreaObject

- (NSString *)description {
   return [NSString stringWithFormat:@"%@ %@ %@",self.province,self.city,self.area];


}

@end

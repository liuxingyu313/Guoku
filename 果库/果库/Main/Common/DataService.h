//
//  DataService.h
//
//
//  Created by kangkathy on 16/5/18.
//  Copyright © 2016年 kangkathy. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^SuccessBlock)(NSURLSessionDataTask *task, id result);
typedef void(^FailureBlock) (NSError *error);

@interface DataService : NSObject



+ (void)requestWithURL:(NSString *)url params:(NSDictionary *)params fileData:(NSDictionary *)fileDic httpMethod:(NSString *)httpMethod success:(SuccessBlock)successBlock failure:(FailureBlock)failBlock;



@end

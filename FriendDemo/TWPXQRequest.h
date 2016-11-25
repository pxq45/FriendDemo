//
//  TWPXQRequest.h
//  FriendDemo
//
//  Created by 小青 on 16/11/22.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWPXQRequest : NSObject

typedef void (^SuccessBlock)(NSDictionary * dic);
+(void)requestWithUrl:(NSString *)urlStr bodyStr:(NSString *)bodyStr success:(SuccessBlock)aSuccess;
@end

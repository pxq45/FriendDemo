//
//  TWPXQRequest.m
//  FriendDemo
//
//  Created by 小青 on 16/11/22.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import "TWPXQRequest.h"

@implementation TWPXQRequest
+(void)requestWithUrl:(NSString *)urlStr bodyStr:(NSString *)bodyStr success:(SuccessBlock)aSuccess
{
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSMutableData * postBody = [NSMutableData data];
    [postBody appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postBody];
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary * outDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"outDic>>>>>>>>>%@",outDic);
            
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:outDic options:NSJSONWritingPrettyPrinted error:nil];
            NSString * str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"str===========%@",str);
            
            aSuccess(outDic);
        }
    }];
    [task resume];
}
@end

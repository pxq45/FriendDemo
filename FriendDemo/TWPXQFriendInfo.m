//
//  TWPXQFriendInfo.m
//  FriendDemo
//
//  Created by 小青 on 16/11/23.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import "TWPXQFriendInfo.h"

@implementation TWPXQFriendInfo
-(NSString *)description
{
    return [NSString stringWithFormat:@"nickName = %@\ngroupId = %@\nheadPicUrl = %@\nuserId = %@\nuserName = %@",self.nickName,self.groupId,self.headPicUrl,self.userId,self.userName];
}
@end

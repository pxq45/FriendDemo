//
//  TWPXQGroupFriend.h
//  FriendDemo
//
//  Created by 小青 on 16/11/23.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWPXQGroupFriend : NSObject
@property (nonatomic, copy) NSString * groupName;
@property (nonatomic, copy) NSString * groupID;
@property (nonatomic, retain) NSMutableArray * friendsArr;
@end

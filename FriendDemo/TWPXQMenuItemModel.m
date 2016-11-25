//
//  TWPXQMenuItemModel.m
//  FriendDemo
//
//  Created by 小青 on 16/11/24.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import "TWPXQMenuItemModel.h"

@implementation TWPXQMenuItemModel
-(id)initWithItemText:(NSString *)itemText
{
    self = [super init];
    if (self) {
        self.itemText = itemText;
    }
    return self;
}
@end

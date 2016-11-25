//
//  TWPXQCellModel.m
//  FriendDemo
//
//  Created by 小青 on 16/11/24.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import "TWPXQCellModel.h"

@implementation TWPXQCellModel

- (id)initWithImageName:(NSString *)imageName labelText:(NSString *)labelText
{
    self = [super init];
    if (self)
    {
        self.imageName = imageName;
        self.labelText = labelText;
    }
    return self;
}

@end

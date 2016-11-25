//
//  TWPXQMenuItemModel.h
//  FriendDemo
//
//  Created by 小青 on 16/11/24.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWPXQMenuItemModel : NSObject

//菜单item的标题
@property (nonatomic, strong) NSString *itemText;

-(id)initWithItemText:(NSString *)itemText;
@end

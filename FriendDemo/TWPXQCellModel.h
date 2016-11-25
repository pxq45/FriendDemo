//
//  TWPXQCellModel.h
//  FriendDemo
//
//  Created by 小青 on 16/11/24.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWPXQCellModel : NSObject

//图片名
@property (nonatomic, strong) NSString *imageName;
//标签内容
@property (nonatomic, strong) NSString *labelText;

- (id)initWithImageName:(NSString *)imageName labelText:(NSString *)labelText;

@end

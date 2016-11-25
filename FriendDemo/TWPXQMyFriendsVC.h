//
//  TWPXQMyFriendsVC.h
//  FriendDemo
//
//  Created by 小青 on 16/11/22.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWPXQMenuCell.h"

@interface TWPXQMyFriendsVC : UIViewController<UITableViewDataSource,UITableViewDelegate,TWPXQMenuCellDataSource,TWPXQMenuCellDelegate>
{
    NSMutableArray * _totalArr;
//    UITableView * _tableView;
}

//列表
@property (strong, nonatomic) UITableView *tableView;

//已经打开下拉菜单的单元格
@property (strong, nonatomic) TWPXQMenuCell *openedMenuCell;
//已经打开下拉菜单的单元格的位置
@property (strong, nonatomic) NSIndexPath *openedMenuCellIndex;

//列表数据源
@property (strong, nonatomic) NSMutableArray *dataSourceArray;
//下拉菜单数据源
@property (strong, nonatomic) NSMutableArray *menuItemDataSourceArray;
@end

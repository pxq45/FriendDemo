//
//  TWPXQMyFriendsVC.m
//  FriendDemo
//
//  Created by 小青 on 16/11/22.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import "TWPXQMyFriendsVC.h"
#import "TWPXQRequest.h"
#import "TWPXQGroupFriend.h"
#import "TWPXQFriendInfo.h"
#import "TWPXQMenuItemModel.h"
#import "UIImageView+WebCache.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

typedef enum
{
    MoveOperation = 0,
    AddToCrowdOperation,
    FreeCallOperation,
    DeleteOperation,
    SendTelephoneBillOperation,
    SendFlowOperation
}OperationType;

@interface TWPXQMyFriendsVC ()

@end

@implementation TWPXQMyFriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的好友";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _totalArr = [[NSMutableArray alloc]init];
    
    [TWPXQRequest requestWithUrl:@"http://www.hxm8828.com/app/friends.php" bodyStr:@"userId=212&op=myfriends" success:^(NSDictionary *dic) {
        NSArray * listArr = dic[@"list"];
        for (NSDictionary * groupDic in listArr)
        {
            TWPXQGroupFriend * groupFriend = [[TWPXQGroupFriend alloc]init];
            groupFriend.groupName = groupDic[@"group_name"];
            groupFriend.groupID = groupDic[@"group_id"];
            groupFriend.friendsArr = [[NSMutableArray alloc]init];
            
            NSArray * friends = groupDic[@"friends"];
            for (NSDictionary * friendDic in friends)
            {
                TWPXQFriendInfo * friendInfo = [[TWPXQFriendInfo alloc]init];
                friendInfo.nickName = friendDic[@"nick_name"];
                friendInfo.groupId = friendDic[@"group_id"];
                friendInfo.headPicUrl = [NSString stringWithFormat:@"http://www.hxm8828.com%@",[friendDic[@"head"] substringFromIndex:2]];
                friendInfo.userId = friendDic[@"user_id"];
                friendInfo.userName = friendDic[@"user_name"];
                [groupFriend.friendsArr addObject:friendInfo];
            }
            [_totalArr addObject:groupFriend];
            
        }
        
        [_tableView reloadData];
    }];
    
    NSArray * itemArray = @[@"移组",@"加入群",@"免费打电话",@"删除好友",@"送话费",@"送流量"];
    _menuItemDataSourceArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < itemArray.count; i++)
    {
        TWPXQMenuItemModel * itemModel = [[TWPXQMenuItemModel alloc]initWithItemText:itemArray[i]];
        [_menuItemDataSourceArray addObject:itemModel];
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TWPXQMenuCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark --- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TWPXQGroupFriend * groupFriend = _totalArr[section];
    return groupFriend.friendsArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWPXQMenuCell * menuCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    menuCell.delegate = self;
    menuCell.dataSource = self;
    menuCell.moreButton.tag = indexPath.row;
    menuCell.moreButton.sectionNum = indexPath.section;
    [menuCell buildMenuView];
    
    TWPXQGroupFriend * groupFriend = _totalArr[indexPath.section];
    
    TWPXQFriendInfo * info = groupFriend.friendsArr[indexPath.row];
    [menuCell.headImageView sd_setImageWithURL:[NSURL URLWithString:info.headPicUrl]];
    menuCell.nickNameLab.text = info.nickName;
    return menuCell;
}

#pragma mark --- UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@">>>>>>%d,%ld",self.openedMenuCell.isOpenMenu,(long)self.openedMenuCellIndex.row);
    if ((self.openedMenuCell != nil)&&
        (self.openedMenuCell.isOpenMenu = YES)&&
        (self.openedMenuCellIndex.row == indexPath.row)&&
        (self.openedMenuCellIndex.section == indexPath.section))
    {
        return 132.0;
    }
    else
    {
        return 44.0;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _totalArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//}
#pragma mark --- TWPXQMenuCellDataSource
-(NSMutableArray *)dataSourceForMenuItem
{
    return _menuItemDataSourceArray;
}

#pragma mark --- TWPXQMenuCellDelegate
-(void)didOpenMenuCell:(TWPXQMenuCell *)menuCell withMoreBtn:(TWPXQMoreBtn *)moreBtn
{
    NSIndexPath *openedIndexPath = [NSIndexPath indexPathForRow:moreBtn.tag inSection:moreBtn.sectionNum];
//    NSLog(@"didOpen>>>>>>%d,%ld",self.openedMenuCell.isOpenMenu,(long)self.openedMenuCellIndex.row);
    if ((self.openedMenuCell != nil)&&
        (self.openedMenuCell.isOpenMenu = YES)&&
        (self.openedMenuCellIndex.row == openedIndexPath.row)&&
        (self.openedMenuCellIndex.section == openedIndexPath.section))
    {
        //如果点的是同一个cell关闭下拉菜单并且不刷新新的cell
        self.openedMenuCell = nil;
        [self.tableView reloadRowsAtIndexPaths:@[self.openedMenuCellIndex] withRowAnimation:UITableViewRowAnimationFade];
        self.openedMenuCellIndex = nil;
        return;
    }
    
    //刷新新的Cell
    self.openedMenuCell = menuCell;
    self.openedMenuCellIndex = openedIndexPath;
    [self.tableView reloadRowsAtIndexPaths:@[self.openedMenuCellIndex] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView scrollToRowAtIndexPath:self.openedMenuCellIndex
                          atScrollPosition:UITableViewScrollPositionNone
                                  animated:YES];
}

-(void)menuTableViewCell:(TWPXQMenuCell *)menuCell didSeletedMenuItemAtIndex:(NSInteger)menuItemIndex
{
    //首先关闭打开的下拉菜单
//    if ((self.openedMenuCell != nil)&&
//        (self.openedMenuCell.isOpenMenu = YES)&&
//        (self.openedMenuCellIndex.row == menuCell.moreButton.tag)&&
//        (self.openedMenuCellIndex.section == menuCell.moreButton.sectionNum))
//    {
//        //如果点的是同一个cell关闭下拉菜单并且不刷新新的cell
//        self.openedMenuCell = nil;
//        [self.tableView reloadRowsAtIndexPaths:@[self.openedMenuCellIndex] withRowAnimation:UITableViewRowAnimationFade];
//        self.openedMenuCellIndex = nil;
//    }
    TWPXQGroupFriend * groupFriend = _totalArr[menuCell.moreButton.sectionNum];
    TWPXQFriendInfo * friendInfo = groupFriend.friendsArr[menuCell.moreButton.tag];
    NSLog(@"friendInfo>>>>>>>%@",friendInfo);
    //根据点击的下拉菜单的item触发相应的事件
    switch (menuItemIndex)
    {
        case MoveOperation:
        {
            
        }
            break;
        case AddToCrowdOperation:
        {
            
        }
            break;
        case FreeCallOperation:
        {
            
        }
            break;
        case DeleteOperation:
        {
            
        }
            break;
        case SendTelephoneBillOperation:
        {
            
        }
            break;
        case SendFlowOperation:
        {
            
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  TWPXQMenuCell.h
//  FriendDemo
//
//  Created by 小青 on 16/11/22.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWPXQMoreBtn.h"

@protocol TWPXQMenuCellDataSource;
@protocol TWPXQMenuCellDelegate;

@interface TWPXQMenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *menuView;
//@property (strong, nonatomic) IBOutlet UIButton *moreBtn;
@property (strong, nonatomic) TWPXQMoreBtn *moreButton;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLab;
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

@property (assign, nonatomic) BOOL isOpenMenu;

@property (strong, nonatomic) id<TWPXQMenuCellDelegate> delegate;
@property (strong, nonatomic) id<TWPXQMenuCellDataSource> dataSource;

-(void)customCell;
-(void)buildMenuView;

@end

@protocol TWPXQMenuCellDataSource <NSObject>

@required
-(NSMutableArray *)dataSourceForMenuItem;

@end

@protocol TWPXQMenuCellDelegate <NSObject>

@optional
-(void)didOpenMenuCell:(TWPXQMenuCell *)menuCell withMoreBtn:(TWPXQMoreBtn *)moreBtn;
-(void)menuTableViewCell:(TWPXQMenuCell *)menuCell didSeletedMenuItemAtIndex:(NSInteger)menuItemIndex;

@end

//
//  TWPXQMenuCell.m
//  FriendDemo
//
//  Created by 小青 on 16/11/22.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import "TWPXQMenuCell.h"
#import "TWPXQMenuItemModel.h"

#define MENU_ITEM_WIDTH  ([[UIScreen mainScreen] bounds].size.width - 5*5)/4
#define MENU_ITEM_SPACE  5

@interface TWPXQMenuCell ()

//下拉菜单数据源
@property (nonatomic, strong) NSMutableArray *menuItemDataSourceArray;

//是否已经绘制了下拉菜单
@property (nonatomic, assign) BOOL isAlreadyDrawMenu;

@end

@implementation TWPXQMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self customCell];
}

-(void)customCell
{
    //最重要的一句代码！没有的话单元格直接全部显示下拉菜单了！两句随便选一句
    self.layer.masksToBounds = YES;
    //    self.clipsToBounds = YES;
    //设置cell自身属性(必须设置，不然收起下拉菜单动画可能有问题)
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置头像圆角
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2;
    self.headImageView.layer.masksToBounds = YES;
    
    //绑定事件
//    [self.moreBtn addTarget:self
//                     action:@selector(moreClick:)
//           forControlEvents:UIControlEventTouchUpInside];
    
    self.moreButton = [TWPXQMoreBtn buttonWithType:UIButtonTypeSystem];
    
    [self.moreButton addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.moreButton];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.moreButton.frame = CGRectMake(self.frame.size.width - 60, 4, 50, 36);
    [self.moreButton setTitle:@"menu" forState:UIControlStateNormal];
    self.menuView.frame = CGRectMake(0, 44, self.frame.size.width, 88);
    
}

-(void)buildMenuView
{
    //避免多次绘制下拉菜单
    if (self.isAlreadyDrawMenu)
    {
        return;
    }
    
    //构建菜单
    self.menuItemDataSourceArray = [NSMutableArray arrayWithCapacity:0];
    if ([self.dataSource respondsToSelector:@selector(dataSourceForMenuItem)])
    {
        self.menuItemDataSourceArray = [self.dataSource dataSourceForMenuItem];
        
        __weak TWPXQMenuCell *weakSelf = self;
        [self.menuItemDataSourceArray enumerateObjectsUsingBlock:^(TWPXQMenuItemModel *menuItemModel, NSUInteger idx, BOOL *stop) {
            
            if (idx >= 8)
            {
                //下拉菜单的item超过最大数(MAX_ITEM_COUNT:5)的时候就不绘制,可以自定义下拉菜单个数
                return ;
            }
            
            CGRect menuItemRect = CGRectMake(MENU_ITEM_SPACE + (MENU_ITEM_SPACE + MENU_ITEM_WIDTH) * (idx%4), 4+44 * (idx/4), MENU_ITEM_WIDTH, 36);
            UIButton *menuItemButton = [UIButton buttonWithType:UIButtonTypeSystem];
            menuItemButton.tag = idx;
            menuItemButton.frame = menuItemRect;
            [menuItemButton setTitle:menuItemModel.itemText forState:UIControlStateNormal];
            [menuItemButton addTarget:self
                               action:@selector(menuItemClick:)
                     forControlEvents:UIControlEventTouchUpInside];
            [weakSelf.menuView addSubview:menuItemButton];
        }];
    }
    
    self.isAlreadyDrawMenu = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // 设置单元格菜单是否被打开，其实可以直接使用isSelected代替。
    self.isOpenMenu = selected;
}

/**
 *  下拉菜单按钮
 *
 *  @param sender 下拉菜单按钮
 */
- (void)moreClick:(TWPXQMoreBtn *)sender
{
    if ([self.delegate respondsToSelector:@selector(didOpenMenuCell:withMoreBtn:)])
    {
        [self.delegate didOpenMenuCell:self withMoreBtn:sender];
    }
}

/**
 *  下拉菜单item点击事件
 *
 *  @param sender 下拉菜单item
 */
- (void)menuItemClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(menuTableViewCell:didSeletedMenuItemAtIndex:)])
    {
        [self.delegate menuTableViewCell:self didSeletedMenuItemAtIndex:sender.tag];
    }
}
@end

//
//  ViewController.m
//  FriendDemo
//
//  Created by 小青 on 16/11/21.
//  Copyright © 2016年 tianhua. All rights reserved.
//

#import "ViewController.h"
#import "TWPXQMyFriendsVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    TWPXQMyFriendsVC * vc = [[TWPXQMyFriendsVC alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    window.rootViewController = nav;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

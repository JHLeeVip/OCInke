//
//  JHBaseNavigationController.m
//  JHInke
//
//  Created by 佳豪 on 2017/2/2.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "JHBaseNavigationController.h"

@interface JHBaseNavigationController ()

@end

@implementation JHBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = RGB(36, 215, 200);//导航栏颜色
    self.navigationBar.tintColor = [UIColor whiteColor];//设置item背后的颜色
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];//不行,这个控制器继承自UIViewController
}

@end

//
//  JHTabBarController.m
//  JHInke
//
//  Created by 佳豪 on 2017/2/2.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "JHTabBarController.h"
#import "JHTabBar.h"
#import "JHBaseNavigationController.h"
#import "JHMainViewController.h"
#import "JHMeViewController.h"
#import "JHLaunchViewController.h"

@interface JHTabBarController ()<JHTabbarDelegate>
/** tabBar */
@property(nonatomic,strong) JHTabBar *jhTabBar;//当心与自带的tabBar名字重复
@end

@implementation JHTabBarController
#pragma mark =====================================
#pragma mark -懒加载
-(JHTabBar *)jhTabBar
{
    if (!_jhTabBar) {
        _jhTabBar = [[JHTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _jhTabBar.delegate = self;//设置代理
    }
    return _jhTabBar;
}


#pragma mark =====================================
#pragma mark -控制器构造相关
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self configChildViewControllers];
    //This is test
    //添加tabBar
    [self.tabBar addSubview:self.jhTabBar];
    //block做逆传的使用
//    self.jhTabBar.tabBarBlock = ^(JHTabBar *tabBar,JHItemType index){
//        
//    };
    
    //去除tabBar上方的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
    
}
-(void)configChildViewControllers{
//    NSArray * arr = @[@"JHMainViewController",@"JHMeViewController"];
    //为了后面的替换复用数组,只有可变数组才有那个替换方法
    NSMutableArray *arr =[[NSMutableArray alloc] initWithArray:@[@"JHMainViewController",@"JHMeViewController"]];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        NSString *VCName = arr[i];
        UIViewController *VC = [[NSClassFromString(VCName) alloc] init];
        JHBaseNavigationController *nav = [[JHBaseNavigationController alloc] initWithRootViewController:VC];
        [arr replaceObjectAtIndex:i withObject:nav];
    }
    
    self.viewControllers = arr;//直接赋值子控制器,TabbarController特有属性?
//    self.childViewControllers = arr;//readonly
}

#pragma mark =====================================
#pragma mark -JHTabbarDelegate
-(void)tabBar:(JHTabBar *)tabBar clickedBtn:(JHItemType)index{
    if (index != JHItemTypeLaunch) {
        //当前选中控制器的索引!
        self.selectedIndex = index - JHItemTypeLive;
        return;
    }
    
    JHLaunchViewController *launchVC = [[JHLaunchViewController alloc] init];
    [self presentViewController:launchVC animated:YES completion:nil];
    
}

@end

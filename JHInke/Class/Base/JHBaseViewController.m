//
//  JHBaseViewController.m
//  JHInke
//
//  Created by 佳豪 on 2017/2/2.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "JHBaseViewController.h"

@interface JHBaseViewController ()

@end

@implementation JHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //方便调试设置随机背景色
    self.view.backgroundColor = RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
}


@end

//
//  JHMainTopView.m
//  JHInke
//
//  Created by 佳豪 on 2017/2/12.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "JHMainTopView.h"

@implementation JHMainTopView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 100, 50);
}

@end

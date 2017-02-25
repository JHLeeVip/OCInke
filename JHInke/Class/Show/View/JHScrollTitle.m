//
//  JHScrollTitle.m
//  JHInke
//
//  Created by 佳豪 on 2017/2/4.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "JHScrollTitle.h"

@implementation JHScrollTitle

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:18];
        self.textColor = [UIColor colorWithRed:0.7 green:.7 blue:.7 alpha:1];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)setScale:(CGFloat)scale{
    _scale = scale;
    //颜色渐变
    CGFloat red = 0.95 + (1 - 0.95) * scale;
    CGFloat green = 0.95 + (1 - 0.95) * scale;
    CGFloat blue = 0.95 + (1 - 0.95) * scale;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    //字体大小渐变
    CGFloat transformScale = 1 + scale * 0.2;//缩放比例[1,1.2]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}
@end

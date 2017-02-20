//
//  JHTabBar.m
//  JHInke
//
//  Created by 佳豪 on 2017/2/2.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "JHTabBar.h"

//类扩展
@interface JHTabBar ()
/** tabBar背景图片 */
@property(nonatomic,strong) UIImageView *tabBarBgView;
/** 图标名称数组 */
@property(nonatomic,strong) NSArray *dataList;
/** 上一个按钮 */
@property(nonatomic,strong) UIButton *preBtn;
/** 直播按钮 */
@property(nonatomic,strong) UIButton *cameraBtn;
@end

@implementation JHTabBar
#pragma mark =====================================
#pragma mark -懒加载
-(UIImageView *)tabBarBgView
{
    if (!_tabBarBgView) {
        _tabBarBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabBarBgView;
}
-(NSArray *)dataList
{
    if (!_dataList) {
        _dataList = @[@"tab_live",@"tab_me"];
    }
    return _dataList;
}
-(UIButton *)cameraBtn
{
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraBtn.tag = JHItemTypeLaunch;
        [_cameraBtn setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
//        [_cameraBtn sizeToFit];//不能在这里写!没用
        [_cameraBtn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraBtn;
}

#pragma mark =====================================
#pragma mark -重写构造方法相关
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {//父类的该方法执行成功后继续
        //获取背景
        [self addSubview:self.tabBarBgView];
        
        //装载item
        for (NSInteger i = 0; i < self.dataList.count; i++) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            item.adjustsImageWhenHighlighted = NO;//取消点击按钮时的图片高亮
            [item setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:[self.dataList[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];//选中状态下的按钮图片
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];//添加按钮点击事件
            item.tag = JHItemTypeLive + i;//设定按钮的标签
            //默认选中Live按钮
            if (item.tag == JHItemTypeLive) {
                item.selected = YES;
                self.preBtn = item;
            }
            [self addSubview:item];
            [self addSubview:self.cameraBtn];//添加直播按钮
        }
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    self.tabBarBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);//tabBar高度是49
    self.tabBarBgView.frame = self.bounds;//这样更严谨,创建tabbar时设置一次就行
    CGFloat width = SCREEN_WIDTH / self.dataList.count;
    
    for (NSInteger i = 0; i < [self subviews].count; i++) {//tabBar子控件数
        UIView *btn = [self subviews][i];
        if ([btn isKindOfClass:[UIButton class]]) {//取出子控件中的Btn
            btn.frame = CGRectMake((btn.tag - JHItemTypeLive) * width, 0, width, self.bounds.size.height);
        }
    }
    [_cameraBtn sizeToFit];//??
    self.cameraBtn.center = CGPointMake(SCREEN_WIDTH/2, 0);//设置直播按钮的中心点
    
}

#pragma mark =====================================
#pragma mark -按钮点击事件
-(void)clickItem:(UIButton *)btn{
    
    //判断代理是否实现代理方法
    if ([self.delegate respondsToSelector:@selector(tabBar:clickedBtn:)]) {
        [self.delegate tabBar:self clickedBtn:btn.tag];//传值
    }
    
    //block
//    if (self.tabBarBlock) {
//        self.tabBarBlock(self,btn.tag);
//    }
    
//    a > b ? a : b;
    !self.tabBarBlock?:self.tabBarBlock(self,btn.tag);//无block执行空,有block执行block,更优雅的写法!
    
    if (btn.tag == JHItemTypeLaunch) {
        return;//如果是直播按钮就直接返回不执行动画,时机!
    }
    
    //还是得放在后面,不然点击直播按钮会影响
    self.preBtn.selected = NO;//上一个按钮恢复原样
    btn.selected = YES;
    self.preBtn = btn;
    
    //点击按钮时要有动画
    [UIView animateWithDuration:0.2 animations:^{
        //将btn扩大1.2被
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        //将btn恢复原样
        btn.transform = CGAffineTransformIdentity;
    }];
    
}



@end

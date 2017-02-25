//
//  JHMainViewController.m
//  JHInke
//
//  Created by 佳豪 on 2017/2/2.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "JHMainViewController.h"
#import "JHFocusViewController.h"
#import "JHHotViewController.h"
#import "JHNearViewController.h"
#import "JHScrollTitle.h"
#import "JHMainTopView.h"

@interface JHMainViewController ()<UIScrollViewDelegate>
/** 导航栏内容数组 */
@property(nonatomic,strong) NSArray *dataList;
/** 可滑动titleView */
@property(nonatomic,strong) JHMainTopView *topTitleView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation JHMainViewController
#pragma mark =====================================
#pragma mark -懒加载
- (NSArray *)dataList
{
    if (!_dataList) {
        _dataList = @[@"关注",@"热门",@"附近",@"才艺",@"好声音"];
    }
    return _dataList;
}
- (JHMainTopView *)topTitleView
{
    if (!_topTitleView) {
        _topTitleView = [[[NSBundle mainBundle] loadNibNamed:@"JHMainTopView" owner:self options:nil] lastObject];
    }
    return _topTitleView;
}

#pragma mark =====================================
#pragma mark -控制器构造相关
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self setUpUI];
}
- (void)setUpUI{
    //设置导航栏
    [self setupNav];
    //添加子控制器
    [self setupChildViewControllers];
    [self setupTitle];
//    默认显示"热门"控制器,直接先调用代理方法
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}
- (void)setupChildViewControllers{
    NSArray *arr = @[@"JHFocusViewController",@"JHHotViewController",@"JHNearViewController",@"JHFocusViewController",@"JHFocusViewController"];
    for (NSInteger i = 0; i < arr.count; i++) {
        NSString *VCName = arr[i];
        UIViewController *VC = [[NSClassFromString(VCName) alloc] init];
        VC.title = self.dataList[i];
        [self addChildViewController:VC];//添加子控制器
    }
//    self.viewControllers = arr;//UIViewController没有这个属性
}
- (void)setupNav{
    //设置导航栏item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
    //添加自定义标题
    self.navigationItem.titleView = self.topTitleView;
}
- (void)setupTitle{
    CGFloat labelW = 100;
    CGFloat labelY = 0;
    CGFloat labelH = self.topTitleView.titleScrollView.bounds.size.height;
    
    //添加label
    for (NSInteger i = 0; i < self.dataList.count; i++) {
        CGFloat labelX = i * labelW;
        JHScrollTitle * label = [[JHScrollTitle alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];//直接init也会调用initWithFrame方法
        label.text = self.dataList[i];
        //添加手势
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelCilik:)]];
        label.tag = i;
        [self.topTitleView.titleScrollView addSubview:label];
        if (i == 1) {//默认热门
            label.scale = 1.0;
        }
    }
    //设置contentSize
    self.topTitleView.titleScrollView.contentSize = CGSizeMake(self.dataList.count * labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(self.dataList.count * SCREEN_WIDTH, 0);
}

#pragma mark =====================================
#pragma mark -按钮点击相关
- (void)labelCilik:(UITapGestureRecognizer *)tap{
    //取出被点击label的索引
    NSInteger index = tap.view.tag;
    //让底部的内容滚动到相应位置
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark =====================================
#pragma mark -UIScrollViewDelegate
/** scrollView滚动时持续监听的方法 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //为整型浮点型数字的操作铺垫
    CGFloat scale = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //内容已经滑动到了左边界或右边界,不改变Title的scale
    if (scale < 0 || scale > self.topTitleView.titleScrollView.subviews.count - 1) return;
    
    //获得需要操作的左边的title
    //核心代码!!!浮点型==>整型
    NSInteger leftIndex = scale;
    JHScrollTitle *leftLabel = self.topTitleView.titleScrollView.subviews[leftIndex];
    
    //获得需要操作的右边的title
    NSInteger rightIndex = leftIndex + 1;
    //这是坑!!!rightIndex在内容滑动到最后的时候一瞬间能到5,超出subViews数组边界!
    JHScrollTitle *rightLabel = (rightIndex == self.topTitleView.titleScrollView.subviews.count)?nil:self.topTitleView.titleScrollView.subviews[rightIndex];
    
    //右边title变化比例
    CGFloat rightScale = scale - leftIndex;
    //左边title变化比例
    CGFloat leftScale = rightIndex - scale;
    
    //执行变化
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
}
/** 手指松开scrollView后,scrollView停止减速完毕就会调用这个方法 */
//继续调取动画结束方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
/** 结束了滚动动画以后就会调用这个方法 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT - 64;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //当前位置需要显示控制器的索引
    NSInteger index = offsetX / width;
    
    //让对应的顶部标题居中显示
    JHScrollTitle *label = self.topTitleView.titleScrollView.subviews[index];
    CGPoint titleOffset = self.topTitleView.titleScrollView.contentOffset;
    titleOffset.x = label.center.x - self.topTitleView.titleScrollView.bounds.size.width * 0.5;
    //左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    //右边超出处理!!!!!!
    //取出最大偏移值
    CGFloat maxTitleOffsetX = self.topTitleView.titleScrollView.contentSize.width - self.topTitleView.titleScrollView.bounds.size.width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    //执行滑动,以此为中心思考偏移
    [self.topTitleView.titleScrollView setContentOffset:titleOffset animated:YES];
    
    //让其他title回到初始状态
    for (JHScrollTitle * otherLabel in self.topTitleView.titleScrollView.subviews) {
        //遍历scrollView中的所有子控件,所以要把进度条去除
        if(otherLabel != label) otherLabel.scale = 0.0;
    }
    
    //取出需要显示的控制器
    UIViewController  *willShowVC = self.childViewControllers[index];
    //如果当前位置的控制器已经加载过了,就直接返回
    if ([willShowVC isViewLoaded]) return;
    
    //添加控制器的View到contentScrollView中
    willShowVC.view.frame = CGRectMake(index * width, 0, width, height);
    [self.contentScrollView addSubview:willShowVC.view];
}


@end

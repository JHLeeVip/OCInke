//
//  JHTabBar.h
//  JHInke
//
//  Created by 佳豪 on 2017/2/2.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import <UIKit/UIKit.h>

//写一个枚举
typedef NS_ENUM(NSUInteger,JHItemType) {
    JHItemTypeLaunch = 10,
    JHItemTypeLive = 100, //展示直播
    JHItenTypeMe, //我的
};

@class JHTabBar;

//block枚举
typedef void(^JHTabBarBlock)(JHTabBar *tabBar,JHItemType index);

@protocol JHTabbarDelegate <NSObject>

-(void)tabBar:(JHTabBar *)tabBar clickedBtn:(JHItemType)index;

@end

@interface JHTabBar : UIView
//写代理和block以便响应事件
/** 代理属性 */
@property(nonatomic,weak) id<JHTabbarDelegate> delegate;
/** block属性 */
@property(nonatomic,copy) JHTabBarBlock tabBarBlock;

@end

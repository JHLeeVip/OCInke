//
//  JHMacro.h
//  JHInke
//
//  Created by 佳豪 on 2017/2/2.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#ifndef JHMacro_h
#define JHMacro_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define RGB(x,y,z) [UIColor colorWithRed:(x/255.0) green:(y/255.0) blue:(z/255.0) alpha:1];

/** 弱引用self */
#define JHweakSelf __weak typeof(self) weakSelf = self

/** 打印方法 */
#define JHLogFunc JHLog(@"%s", __func__);

#ifdef DEBUG // 如果定义了DEBUG这个宏，说明是处在调试阶段
#define JHLog(...) NSLog(__VA_ARGS__);
#else // 不是调试阶段，是发布阶段
#define JHLog(...)
#endif

//UTF8转中文
#define UTF8TOCHINESEWITH(json) [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]


#endif /* JHMacro_h */

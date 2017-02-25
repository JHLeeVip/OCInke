//
//  MJExtensionConfig.m
//  JHInke
//
//  Created by 佳豪 on 2017/2/25.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "MJExtension.h"
#import "JHLive.h"
#import "JHCreator.h"


@implementation MJExtensionConfig

+ (void)load{
#pragma mark -NSObject中的ID属性对应着字典中的id,如果使用NSObject来调用这些方法,代表所有继承自NSObject的类都会生效
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
    
#pragma mark -驼峰转下划线
    [JHLive mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    [JHCreator mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
}

@end

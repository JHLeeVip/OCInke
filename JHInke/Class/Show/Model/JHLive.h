//
//  JHLive.h
//  JHInke
//
//  Created by 佳豪 on 2017/2/25.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class JHCreator;
#import "JHCreator.h"

@interface JHLive : NSObject

@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) JHCreator * creator;
//@property (nonatomic, strong) Extra * extra;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, assign) NSInteger landscape;
@property (nonatomic, assign) NSInteger link;
@property (nonatomic, strong) NSString * liveType;
@property (nonatomic, assign) NSInteger multi;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger onlineUsers;
@property (nonatomic, assign) NSInteger optimal;
@property (nonatomic, assign) NSInteger rotate;
@property (nonatomic, strong) NSString * shareAddr;
@property (nonatomic, assign) NSInteger slot;
@property (nonatomic, strong) NSString * streamAddr;
@property (nonatomic, assign) NSInteger tagId;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, assign) NSInteger version;


@end

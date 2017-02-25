//
//  JHLiveHandler.m
//  JHInke
//
//  Created by 佳豪 on 2017/2/12.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "JHLiveHandler.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "JHLive.h"


@implementation JHLiveHandler
+(void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    [HttpTool getWithPath:API_HotLive params:nil success:^(id json) {
//        JHLog(@"%@",UTF8TOCHINESEWITH(json));
        if ([json[@"dem_error"] integerValue]) {
            failed(json[@"error_msg"]);
        }
        //如果返回信息正确,解析数据,直接回传模型数组
        NSArray * lives = [JHLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
        success(lives);
        JHLog(@"%@",UTF8TOCHINESEWITH(json));
        
    } failure:^(NSError *error) {
        failed(error);
    }];
}
@end

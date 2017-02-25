//
//  JHBaseHandler.h
//  JHInke
//
//  Created by 佳豪 on 2017/2/12.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 处理完成事件 */
typedef void(^CompleteBlock)();

/** 成功,返回数据模型 */
typedef void(^SuccessBlock)(id obj);

/** 失败,返回错误信息 */
typedef void(^FailedBlock)(id obj);

@interface JHBaseHandler : NSObject


@end

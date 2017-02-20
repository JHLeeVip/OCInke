//
//  JHLiveHandler.h
//  JHInke
//
//  Created by 佳豪 on 2017/2/12.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "JHBaseHandler.h"

@interface JHLiveHandler : JHBaseHandler
+(void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;
@end

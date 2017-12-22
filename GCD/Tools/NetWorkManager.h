//
//  NetWorkManager.h
//  GCD
//
//  Created by RaoBo on 2017/12/22.
//  Copyright © 2017年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlock) (id responObjc);
typedef void(^FailureBlock)(NSError *err);

@interface NetWorkManager : NSObject

/**请求1*/
+ (void)firstRequestWithSucces:(SuccessBlock)success
                   failure:(FailureBlock)failure;

/**请求2*/
+ (void)secondRequestWithSucces:(SuccessBlock)success
                        failure:(FailureBlock)failure;

/**请求3*/
+ (void)thirdRequestWithSucces:(SuccessBlock)success
                       failure:(FailureBlock)failure;


@end

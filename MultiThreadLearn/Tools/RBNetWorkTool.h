//
//  RBNetWorkTool.h
//  MultiThreadLearn
//
//  Created by RaoBo on 2018/7/13.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <Foundation/Foundation.h>
//typedef void (^RBCompletionBlock)()
typedef void(^RBSuccessBlock)(NSDictionary *responObjc);
typedef void(^RBFailureBlock)(NSError *error);

@interface RBNetWorkTool : NSObject
//+ (void)rb_getWithUrl:(NSString *)url parDic:(NSDictionary *)dic successH:(RBSuccessBlock)success failH:(RBFailureBlock)fail;
//
//+ (void)rb_postWithUlr:(NSString *)urlStr parDic:(NSDictionary *)dic successH:(RBSuccessBlock)success failH:(RBFailureBlock)fail;

//GET无参数
+ (void)firstRequestSuccessH:(RBSuccessBlock)success failH:(RBFailureBlock)fail;
//GET有参数
+ (void)secondRequestSuccessH:(RBSuccessBlock)success failH:(RBFailureBlock)fail;
//POST
+ (void)thirdRequestSuccessH:(RBSuccessBlock)success failH:(RBFailureBlock)fail;


@end

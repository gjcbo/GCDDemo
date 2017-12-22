//
//  SemaphoreViewController.m
//  GCD
//
//  Created by RaoBo on 2017/12/22.
//  Copyright © 2017年 RaoBo. All rights reserved.
//

#import "SemaphoreViewController.h"
#import "NetWorkManager.h"
@interface SemaphoreViewController ()

@end

@implementation SemaphoreViewController

#pragma mark - 需求:
/**
 多个网络请求有依赖关系，如何实现多个网络请求顺序执行,第一个请求拿到数据之后才可以进行第二个请求，同理第二个请求拿到数据之后，才可以进行第三个网络请求。
 网络请求1
 网络请求2
 网络请求3
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *noSemapBtn = [UIButton rb_ButtonWithFrame:CGRectMake(50, 100, 150, 50) target:self action:@selector(noSemaphoreAction:) title:@"使用信号量"];
    
    UIButton *semapBtn = [UIButton rb_ButtonWithFrame:CGRectMake(50, 250, 150, 50) target:self action:@selector(semaphoreAction:) title:@"使用信号量"];
    
    [self.view addSubview:noSemapBtn];
    
    [self.view addSubview:semapBtn];
}

- (void)noSemaphoreAction:(UIButton *)btn{
    NSLog(@"不使用信号量");
    [self request1];
    [self request2];
    [self request3];
}

- (void)semaphoreAction:(UIButton *)btn
{
    NSLog(@"使用信号量");
    
    // 创建信号量:初始值为0
    dispatch_semaphore_t semap = dispatch_semaphore_create(0);
    
    // 创建队列
    dispatch_queue_t queue1 = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue1, ^{
        [self request1WithSemaPhore:semap];
        [self request2WithSemaphore:semap];
        [self request3WithSemaPhore:semap];
    });
}

#pragma mark - 网络请求 使用信号量
- (void)request1WithSemaPhore:(dispatch_semaphore_t)semap
{
    [NetWorkManager firstRequestWithSucces:^(id responObjc) {
        
        NSLog(@"1.请求一成功:%d",__LINE__);
        dispatch_semaphore_signal(semap);
    } failure:^(NSError *err) {
        NSLog(@"1.一请求失败:%@",err);
        dispatch_semaphore_signal(semap);
    }];
    
    dispatch_semaphore_wait(semap, DISPATCH_TIME_FOREVER);
}

- (void)request2WithSemaphore:(dispatch_semaphore_t)semap
{
    [NetWorkManager secondRequestWithSucces:^(id responObjc) {
    
        NSLog(@"2.请求二成功:%d",__LINE__);
        dispatch_semaphore_signal(semap);
    } failure:^(NSError *err) {
        NSLog(@"2.请求二失败%@",err);
        dispatch_semaphore_signal(semap);
    }];
    
    dispatch_semaphore_wait(semap, DISPATCH_TIME_FOREVER);
}

- (void)request3WithSemaPhore:(dispatch_semaphore_t)semap
{
    [NetWorkManager thirdRequestWithSucces:^(id responObjc) {
        
        NSLog(@"3.请求三成功:%d",__LINE__);
        dispatch_semaphore_signal(semap);
    } failure:^(NSError *err) {
        NSLog(@"3.请求三失败:%d",__LINE__);
        dispatch_semaphore_signal(semap);
    }];
    
    dispatch_semaphore_wait(semap, DISPATCH_TIME_FOREVER);
}
// 每19年阴历阳历重复日期重复一次，

#pragma mark - 网络请求 不使用信号量
- (void)request1
{
    [NetWorkManager firstRequestWithSucces:^(id responObjc) {
        
        NSLog(@"1.请求一成功:%d",__LINE__);
    } failure:^(NSError *err) {
        
        NSLog(@"1.一请求失败:%@",err);
    }];
}
- (void)request2
{
    [NetWorkManager secondRequestWithSucces:^(id responObjc) {
        
        NSLog(@"2.请求二成功:%d",__LINE__);
    } failure:^(NSError *err) {
        NSLog(@"2.请求二失败%@",err);
    }];
}

- (void)request3
{
    [NetWorkManager thirdRequestWithSucces:^(id responObjc) {
        
        NSLog(@"3.请求三成功:%d",__LINE__);
    } failure:^(NSError *err) {
        NSLog(@"3.请求三失败:%d",__LINE__);
    }];
}
@end

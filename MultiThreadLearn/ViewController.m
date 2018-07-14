//
//  ViewController.m
//  MultiThreadLearn
//
//  Created by RaoBo on 2018/4/5.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "ViewController.h"
#import "GCDTableViewController.h"
#import "RBNetWorkTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *gcdBtn = [UIButton rb_buttonWithFrame:CGRectMake(50, 100, kScreen_W-100, 50) target:self action:@selector(clickGCDAction:) title:@"GCD相关"];
    [self.view addSubview:gcdBtn];
    
    
    UIButton *semaphoreBtn = [UIButton rb_buttonWithFrame:CGRectMake(50, 200, kScreen_W-100, 50) target:self action:@selector(clickSemaphoreBtnAction:) title:@"使用信号量多个网络请求顺序执行"];
    [self.view addSubview:semaphoreBtn];

    
    UIButton *noSempBtn = [UIButton rb_buttonWithFrame:CGRectMake(50, 300, kScreen_W-100, 50) target:self action:@selector(clickNoSemaAction:) title:@"不用信号量的结果"];
    [self.view addSubview:noSempBtn];

}


- (void)clickGCDAction:(UIButton *)btn
{
    GCDTableViewController *gcdVC = [[GCDTableViewController alloc] init];
    [self.navigationController pushViewController:gcdVC animated:YES];
}

#pragma mark - 一 使用信号量实现多个网络请求顺序执行
// 使用信号量实现多个网络请求顺序执行
- (void)clickSemaphoreBtnAction:(UIButton *)btn {
    //初始信号量
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    [self request1WithSemaphore:sema];
    [self request2WithSemaphore:sema];
    [self request3WithSemaphore:sema];
    
    NSLog(@"=================");
}

- (void)request1WithSemaphore:(dispatch_semaphore_t)sema{
    
    [RBNetWorkTool firstRequestSuccessH:^(NSDictionary *responObjc) {
        
        NSLog(@"11111成功");
        dispatch_semaphore_signal(sema);
        
    } failH:^(NSError *error) {
        NSLog(@"11111失败");
        
        dispatch_semaphore_signal(sema);
    }];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

- (void)request2WithSemaphore:(dispatch_semaphore_t)sema{
    [RBNetWorkTool secondRequestSuccessH:^(NSDictionary *responObjc) {
        NSLog(@"2222成功");
        dispatch_semaphore_signal(sema);
        
    } failH:^(NSError *error) {
        NSLog(@"22222失败");
        dispatch_semaphore_signal(sema);
    }];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}
- (void)request3WithSemaphore:(dispatch_semaphore_t)sema {
    [RBNetWorkTool thirdRequestSuccessH:^(NSDictionary *responObjc) {
        NSLog(@"33333成功");
        dispatch_semaphore_signal(sema);
        
    } failH:^(NSError *error) {
        NSLog(@"33333失败");
        dispatch_semaphore_signal(sema);
    }];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}


#pragma mark - 二 不使用信号量
//使用信号量的情况
- (void)clickNoSemaAction:(UIButton *)btn {
    [self request1];
    [self request2];
    [self request3];
    NSLog(@"==============");
}

- (void)request1 {
    [RBNetWorkTool firstRequestSuccessH:^(NSDictionary *responObjc) {
        
        NSLog(@"11111成功");
    } failH:^(NSError *error) {
        NSLog(@"11111失败");
    }];
}
- (void)request2 {
    [RBNetWorkTool secondRequestSuccessH:^(NSDictionary *responObjc) {
        NSLog(@"2222成功");
        
    } failH:^(NSError *error) {
        NSLog(@"22222失败");
    }];
}
- (void)request3 {
    [RBNetWorkTool thirdRequestSuccessH:^(NSDictionary *responObjc) {
        NSLog(@"33333成功");
        
    } failH:^(NSError *error) {
        NSLog(@"33333失败");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

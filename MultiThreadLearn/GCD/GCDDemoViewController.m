//
//  GCDDemoViewController.m
//  MultiThreadLearn
//
//  Created by RaoBo on 2018/4/5.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "GCDDemoViewController.h"

@interface GCDDemoViewController ()

@end

@implementation GCDDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *runBtn = [UIButton rb_buttonWithFrame:CGRectMake(50, kScreen_H - 200, kScreen_W - 100, 50) target:self action:@selector(runAction) title:@"查看运行结果"];
    [self.view addSubview:runBtn];
    
}
#pragma mark - 一 获取队列的三种方式:
// 获取串行队列
- (void)testSerialqueue{
   NSLog(@"%s--%d",__FUNCTION__,__LINE__);
    
    // 创建串行队列。方式一 DISPATCH_QUEUE_SERIAL
//    dispatch_queue_t serialQueue1 = dispatch_queue_create("com.guanjianci.gcd.MySerialDispatchQueu", DISPATCH_QUEUE_SERIAL);
    
    // 第二个参数如果填 NULL,默认为串行队列
//    dispatch_queue_t serialQ2 = dispatch_queue_create("com.guanjianci.gcd.MySerialDispatchQueu", NULL);
    
    // 获取主队列, 主队了是串行队列。
//    dispatch_queue_t mainQ = dispatch_get_main_queue();
}

// 创建并行队列
- (void)testConcurrentqueue
{
    NSLog(@"%s--%d",__FUNCTION__,__LINE__);
    // 创建并发队列
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.guanjianci.gcd.MySerialDispatchQueu", DISPATCH_QUEUE_CONCURRENT);
    
    
    // 全局并发队列:系统提供 可以直接使用。第一个参数表示队列优先级,第二个参数是保留字段,一般填0
//    dispatch_queue_t globalConcurrentQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
}
// 获取主队列
- (void)textMainqueue{
    
    // 主队列。
//   dispatch_queue_t mainQ = dispatch_get_main_queue();
}


#pragma mark - 二 任务的两种追加方式(同步任务、异步任务)
- (void)testSync{
    
    // 创建队列
   dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 将任务以同步的方式添加到队列
    dispatch_sync(globalQ, ^{
        
        NSLog(@"这里放同步任务要执行的代码");
    });
}

- (void)textAsync {
    
    // 创建队列
    dispatch_queue_t queue = dispatch_queue_create("com.test.ConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    // 将任务以异步的方式添加到队列
    dispatch_async(queue, ^{
       
        // 任务代码
    });
}


#pragma mark - 

#pragma mark - 点击运行按钮
- (void)runAction
{
    
    SEL selectedSEL = NSSelectorFromString(self.selString);
    
    if ([self respondsToSelector:selectedSEL]) {

        // 这个有警告⚠️
        [self performSelector:selectedSEL];
    }
}


@end

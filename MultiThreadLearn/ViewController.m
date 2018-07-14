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
    
    UIButton *gcdBtn = [UIButton rb_buttonWithFrame:CGRectMake(50, 200, kScreen_W-100, 50) target:self action:@selector(clickGCDAction:) title:@"GCD相关"];
    [self.view addSubview:gcdBtn];
}


- (void)clickGCDAction:(UIButton *)btn
{
//    GCDTableViewController *gcdVC = [[GCDTableViewController alloc] init];
//    [self.navigationController pushViewController:gcdVC animated:YES];
    
    [self request1WithSemaphore];
    [self request2WithSemaphore];
    [self request3WithSemaphore];
    
    NSLog(@"=================");
}


- (void)request1WithSemaphore{
    [RBNetWorkTool firstRequestSuccessH:^(NSDictionary *responObjc) {
//        NSLog(@"11111成功:%@",responObjc);
        NSLog(@"11111成功");

    } failH:^(NSError *error) {
        NSLog(@"11111失败");
    }];
}

- (void)request2WithSemaphore{
    [RBNetWorkTool secondRequestSuccessH:^(NSDictionary *responObjc) {
        NSLog(@"2222成功");
    } failH:^(NSError *error) {
        NSLog(@"22222失败");
    }];
}
- (void)request3WithSemaphore {
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

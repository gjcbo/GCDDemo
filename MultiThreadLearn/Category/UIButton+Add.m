//
//  UIButton+Add.m
//  MultiThreadLearn
//
//  Created by RaoBo on 2018/4/5.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "UIButton+Add.h"

#define RBColorA(r,g,b,a) [UIColor colorWithRed:(r) /255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RBColor(r,g,b) RBColorA(r,g,b,1)
#define RBRandomColor  RBColor(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255))

@implementation UIButton (Add)
+ (instancetype)rb_buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    btn.frame = frame;
    btn.backgroundColor = RBRandomColor;
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
    
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return btn;
}
@end

//
//  UIButton+RBExtension.m
//  GCD
//
//  Created by RaoBo on 2017/12/22.
//  Copyright © 2017年 RaoBo. All rights reserved.
//

#import "UIButton+RBExtension.h"

@implementation UIButton (RBExtension)
+ (instancetype)rb_ButtonWithFrame:(CGRect)frame target:(id)target action:(SEL)action title:(NSString *)title
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

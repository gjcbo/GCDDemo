//
//  UIButton+RBExtension.h
//  GCD
//
//  Created by RaoBo on 2017/12/22.
//  Copyright © 2017年 RaoBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (RBExtension)

/**
 1.封装button的创建方法

 @param frame frame
 @param target target
 @param action 点击事件
 @return 返回一个button
 @param title 标题
 */
+ (instancetype)rb_ButtonWithFrame:(CGRect)frame target:(id)target action:(SEL)action  title:(NSString *)title;

@end

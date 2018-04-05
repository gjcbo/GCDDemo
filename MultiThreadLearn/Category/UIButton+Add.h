//
//  UIButton+Add.h
//  MultiThreadLearn
//
//  Created by RaoBo on 2018/4/5.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Add)

/**
 创建一个button

 @param frame frame
 @param target target
 @param action 点击事件
 @param title 标题
 @return 返回一个Button 实例
 */
+ (instancetype)rb_buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action title:(NSString *)title;

@end

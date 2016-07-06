//
//  CJKeyboard.h
//  自定义键盘
//
//  Created by chenjun on 16/7/6.
//  Copyright © 2016年 cloudssky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    keyboardTypeDot,
    keyboardTypeSpace,
    keyboardTypeShotline,
    keyboardTypeIDCard
} keyboardType;

@interface CJKeyboard : UIView

@property (nonatomic ,assign) keyboardType boardType;

@end

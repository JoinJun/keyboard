//
//  CJKeyboard.m
//  自定义键盘
//
//  Created by chenjun on 16/7/6.
//  Copyright © 2016年 cloudssky. All rights reserved.
//

#import "CJKeyboard.h"

@interface CJKeyboard ()

@property (nonatomic ,assign) CGFloat width;
@property (nonatomic ,assign) CGFloat height;

@property (nonatomic ,strong) NSMutableArray *keyboardTitle;
//左下角变动的按钮
@property (nonatomic ,strong) UIButton *specialBtn;

@end

@implementation CJKeyboard

- (instancetype)init {
    if (self = [super init]) {
        self.keyboardTitle = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        for (int i = 1; i < 10; i++) {
            [self.keyboardTitle addObject:[NSString stringWithFormat:@"%d", i]];
        }
        [self.keyboardTitle addObject:@"."];
        [self.keyboardTitle addObject:@"0"];
        [self.keyboardTitle addObject:@"C"];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self createView];
}

- (UIImage *)buttonImageFromColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)createView {
    self.height = self.frame.size.height;
    self.width = self.frame.size.width;
//    NSLog(@"%@", self.keyboardTitle);
    for (int i = 0; i < 12; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        btn.frame = CGRectMake(self.width / 3 * (i % 3), self.height / 4 * (i / 3), self.width / 3, self.height / 4);
        [btn setTitle:self.keyboardTitle[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self buttonImageFromColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i == 9) {
            self.specialBtn = btn;
        }
        if (i == 11) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong)];
            longPress.minimumPressDuration = 0.5; //定义按的时间
            [btn addGestureRecognizer:longPress];
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (int i = 0; i < 5; i++) {
        UIView *line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.1;
        line.frame = CGRectMake(0, self.height / 4 * (i), self.width, 1);
    }
    for (int i = 0; i < 4; i++) {
        UIView *line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.1;
        line.frame = CGRectMake(self.width / 3 * (i), 0, 1, self.height);
    }
}

- (void)setBoardType:(keyboardType)boardType {
    _boardType = boardType;
    if (boardType == keyboardTypeDot) {
        [self.keyboardTitle setObject:@"." atIndexedSubscript:9];
    } else if (boardType == keyboardTypeSpace) {
        [self.keyboardTitle setObject:@" " atIndexedSubscript:9];
    } else if (boardType == keyboardTypeShotline) {
        [self.keyboardTitle setObject:@"-" atIndexedSubscript:9];
    } else if (boardType == keyboardTypeIDCard) {
        [self.keyboardTitle setObject:@"X" atIndexedSubscript:9];
    } else {
        [self.keyboardTitle setObject:@"." atIndexedSubscript:9];
    }
    [self.specialBtn setTitle:self.keyboardTitle[9] forState:UIControlStateNormal];
}

- (void)btnClick:(UIButton *)sender {
    NSString *title = [sender currentTitle];
//    NSLog(@"%@", title);
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UITextField *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    NSMutableString *currentString = [NSMutableString stringWithString:firstResponder.text];
    if ([title isEqualToString:@"C"]) {
        if (currentString.length != 0) {
            [currentString deleteCharactersInRange:NSMakeRange(currentString.length - 1, 1)];
            firstResponder.text = currentString;
        }
//    }else if ([title isEqualToString:@"."]) {
//        if ([currentString rangeOfString:@"."].location == NSNotFound) {
//            [currentString appendString:title];
//            firstResponder.text = currentString;
//        }
    } else {
        [currentString appendString:title];
        firstResponder.text = currentString;
    }
}

- (void)btnLong {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UITextField *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    firstResponder.text = @"";
}

@end

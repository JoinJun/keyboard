//
//  ViewController.m
//  自定义键盘
//
//  Created by chenjun on 16/7/6.
//  Copyright © 2016年 cloudssky. All rights reserved.
//

#import "ViewController.h"
#import "CJKeyboard.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CJKeyboard *keyView = [[CJKeyboard alloc] init];
    keyView.frame = CGRectMake(0, 0, 320, 200);
    keyView.boardType = keyboardTypeIDCard;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 320, 40)];
    textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:textField];
    textField.inputView = keyView;
    
    CJKeyboard *keyView2 = [[CJKeyboard alloc] init];
    keyView2.boardType = keyboardTypeIDCard;
    UITextView *teView = [[UITextView alloc] init];
    teView.frame = CGRectMake(10, 170, 300, 200);
    teView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:teView];
    keyView2.boardType = keyboardTypeDot;
    teView.inputView = keyView2;
    keyView2.frame = CGRectMake(0, 0, 280, 400);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end

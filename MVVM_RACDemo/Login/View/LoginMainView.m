//
//  LoginMainView.m
//  MVVM_RACDemo
//
//  Created by collegepre on 2017/9/6.
//  Copyright © 2017年 collegepre. All rights reserved.
//

#import "LoginMainView.h"
#import "LoginViewModel.h"
#import "SVProgressHUD.h"
#import "MainViewController.h"

@interface LoginMainView()
@property (nonatomic, strong) LoginViewModel *loginViewModel;

@property (nonatomic, strong) UITextField *userNameField;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UIButton *loginBtn;

@end


@implementation LoginMainView

- (instancetype)initWithViewModel:(LoginViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:150 green:100 blue:100 alpha:1];
        self.loginViewModel = viewModel;
        [self setupSubView];
        
        [self bindViewModel];
    }
    return self;
}

- (void)setupSubView{
    UITextField *userNameField = [[UITextField alloc] init];
    userNameField.borderStyle = UITextBorderStyleRoundedRect;
    userNameField.backgroundColor = [UIColor lightGrayColor];
    userNameField.frame = CGRectMake(234, 168, 300, 40);
    
    userNameField.placeholder = @"用户名";
    [self addSubview:userNameField];
    self.userNameField = userNameField;
    
    UITextField *pwdField = [[UITextField alloc] init];
    pwdField.borderStyle = UITextBorderStyleRoundedRect;
    pwdField.backgroundColor = [UIColor lightGrayColor];
    pwdField.frame = CGRectMake(234, 220, 300, 40);
    
    pwdField.placeholder =@"密码";
    pwdField.secureTextEntry = YES;
    [self addSubview:pwdField];
    self.pwdField = pwdField;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    loginBtn.frame = CGRectMake(234, 280, 300, 40);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor blueColor]];
    [self addSubview:loginBtn];
    self.loginBtn = loginBtn;
}

- (void)bindViewModel{
    
    RAC(self.loginViewModel.accountInfo,account) = self.userNameField.rac_textSignal;
    RAC(self.loginViewModel.accountInfo,pwd) = self.pwdField.rac_textSignal;
    
    // 绑定登录按钮
    RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;
    
    // 监听登录按钮点击
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.loginViewModel.loginCommand execute:nil];
    }];
    
    [self.loginViewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        [SVProgressHUD showWithStatus:@"Login..."];
        if ([x isEqualToString:@"LoginSuccess"]) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功！"];
            NSLog(@"LoginSuccess");
            MainViewController *vc =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainViewController"];
            [self.loginVc.navigationController pushViewController:vc animated:YES];
        }else if([x isEqualToString:@"LoginFailed"]){
            [SVProgressHUD showSuccessWithStatus:@"登录失败！"];
            NSLog(@"LoginFailed");
        }
    }];
    

}

@end

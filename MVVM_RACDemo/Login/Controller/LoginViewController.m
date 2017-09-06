//
//  ViewController.m
//  MVVM_RACDemo
//
//  Created by collegepre on 16/5/23.
//  Copyright © 2016年 collegepre. All rights reserved.
//

#import "LoginViewController.h"
#import "ReactiveCocoa.h"
#import "LoginViewModel.h"
#import "SVProgressHUD.h"
#import "LoginMainView.h"
#import "MainViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong) LoginViewModel *viewModel;
@property (nonatomic, strong) LoginMainView *loginMainView;

@end

@implementation LoginViewController

- (LoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建View并绑定Viewmodel
    self.loginMainView = [[LoginMainView alloc] initWithViewModel:self.viewModel];
    self.loginMainView.frame = self.view.bounds;
    self.loginMainView.loginVc = self;
    [self.view addSubview:self.loginMainView];
}




@end

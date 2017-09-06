//
//  LoginMainView.h
//  MVVM_RACDemo
//
//  Created by collegepre on 2017/9/6.
//  Copyright © 2017年 collegepre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"
#import "LoginViewController.h"

@interface LoginMainView : UIView
- (instancetype)initWithViewModel:(LoginViewModel *)viewModel;

@property (nonatomic, strong) LoginViewController *loginVc;
@end

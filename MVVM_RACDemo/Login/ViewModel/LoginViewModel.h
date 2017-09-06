//
//  LoginViewModel.h
//  MVVM_RACDemo
//
//  Created by collegepre on 16/5/23.
//  Copyright © 2016年 collegepre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfo.h"
#import "ReactiveCocoa.h"

@interface LoginViewModel : NSObject
@property (nonatomic, strong) AccountInfo *accountInfo;
// 登录按钮可点击信号
@property (nonatomic, strong) RACSignal *enableLoginSignal;

// 登录信息返回信号
@property (nonatomic, strong) RACCommand *loginCommand;

@end

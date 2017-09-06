//
//  LoginViewModel.m
//  MVVM_RACDemo
//
//  Created by collegepre on 16/5/23.
//  Copyright © 2016年 collegepre. All rights reserved.
//

#import "LoginViewModel.h"
#import "AFNetworking.h"
//#import ""

@interface LoginViewModel()
@property (nonatomic, strong) AFHTTPSessionManager *httpManager;
@end

@implementation LoginViewModel

- (AFHTTPSessionManager *)httpManager{
    if (!_httpManager) {
        _httpManager = [AFHTTPSessionManager manager];
        _httpManager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"text/plain", @"text/html",@"text/json", @"application/json",@"text/javascript",nil];
    }
    return _httpManager;
}

- (AccountInfo *)accountInfo{
    if (!_accountInfo) {
        _accountInfo = [[AccountInfo alloc] init];
    }
    return _accountInfo;
}


- (instancetype)init{
    if (self = [super init]) {
        [self initBind];
    }
    return self;
}

// 初始化动态绑定
- (void)initBind
{
      // 监听账号的属性值改变，把他们聚合成一个信号。
    self.enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.accountInfo, account),RACObserve(self.accountInfo, pwd)] reduce:^id(NSString *account , NSString *pwd){
        // 用户名和密码长度大于6的时候返回一个信号，设置登录按钮Enable
        return @(account.length >= 6 && pwd.length >= 6);
    }];
    
    
    // 处理登录信号的
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    // 点击了登录按钮
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [self.httpManager POST:@"https://api.classserver.cn/interfaces/aspen/user/userLogin" parameters:@{@"username":@"SME001000111",@"password":@"dsadsadsadsadsadsa"} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [subscriber sendNext:@"LoginSuccess"];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [subscriber sendNext:@"LoginFailed"];
                [subscriber sendCompleted];
                
            }];
             return nil;
            
        }];
       
    }];
    
    
}

@end

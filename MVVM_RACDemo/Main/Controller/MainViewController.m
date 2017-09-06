//
//  MainViewController.m
//  MVVM_RACDemo
//
//  Created by collegepre on 16/5/23.
//  Copyright © 2016年 collegepre. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end

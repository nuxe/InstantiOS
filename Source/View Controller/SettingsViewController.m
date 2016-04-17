//
//  SettingsViewController.m
//  Instant
//
//  Created by Kush Agrawal on 4/16/16.
//  Copyright © 2016 fdzsergio. All rights reserved.
//

#import "SettingsViewController.h"

#import <Masonry/Masonry.h>

@interface SettingsViewController () <UIScrollViewDelegate>

@end

@implementation SettingsViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor colorWithRed:242.0f / 255.0f green:242.0f / 255.0f blue:244.0f / 255.0f alpha:1.0f];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headerView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];


        view;
    });
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.frame.size.height/3);
    }];

    UIScrollView *scrollView = ({
        UIScrollView *view = [[UIScrollView alloc] init];
        view.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
        view;
    });
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
        

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

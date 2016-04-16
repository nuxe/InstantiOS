//
//  RootViewController.m
//  Instant
//
//  Created by Kush Agrawal on 4/16/16.
//  Copyright © 2016 fdzsergio. All rights reserved.
//

#import "RootViewController.h"
#import "SFResource.h"

#import <Masonry/Masonry.h>

@interface RootViewController () <UIScrollViewDelegate>

@property (nonatomic) SFResource *resource;
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *detailText;
@property (nonatomic, copy) UIImage *backgroundImage;
@property (nonatomic) CGFloat previousScrollViewYOffset;

@end

@implementation RootViewController 

- (instancetype)initWithResource:(SFResource *) resource
{
    if (self = [super init]) {
        _resource = resource;
        _header = resource.title;
        _detailText = resource.detail;
        _backgroundImage = resource.backgroundImage;
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = _header;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(_didTapOnLeftBarButtonItem:)];
    closeButton.tintColor = [UIColor grayColor];
    [self.navigationItem setLeftBarButtonItem:closeButton];

    UIScrollView *scrollView = ({
        UIScrollView *view = [[UIScrollView alloc] init];
        view.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
        view;
    });
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    UIImageView *headerImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.backgroundImage];

        imageView;
    });
    [scrollView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scrollView);
        make.left.right.mas_equalTo(self.view);
    }];

    UIView *grayBackgroundView = [[UIView alloc] init];
    grayBackgroundView.backgroundColor = [UIColor colorWithRed:242.0f / 255.0f green:242.0f / 255.0f blue:244.0f / 255.0f alpha:1.0f];
    [self.view addSubview:grayBackgroundView];
    [grayBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(scrollView);
        make.height.mas_equalTo(60.0f);
    }];


    UIButton *bookButton = [self _primaryButtonWithText:@"Book Now"];
    [grayBackgroundView addSubview:bookButton];
    [bookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(scrollView).mas_offset(UIEdgeInsetsMake(20.0f, 20.0f, 10.0f, 20.0f));
        make.height.mas_equalTo(40.0f);
    }];



    // Do any additional setup after loading the view.
}


- (UIButton *)_primaryButtonWithText:(NSString *)text
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected | UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithRed:178.0f / 255.0f green:178.0f / 255.0f blue:186.0f / 255.0f alpha:1.0f] forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor colorWithRed:178.0f / 255.0f green:178.0f / 255.0f blue:186.0f / 255.0f alpha:1.0f] forState:UIControlStateDisabled | UIControlStateSelected];
    [button setBackgroundImage:[self imageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];

//    [button setBackgroundColor:<#(UIColor * _Nullable)#>]
//    [button setBackgroundColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor colorWithRed:34.0f / 255.0f green:34.0f / 255.0f blue:49.0f / 255.0f alpha:1.0f] forState:UIControlStateHighlighted];
//    [button setBackgroundColor:[UIColor uberBlack90] forState:UIControlStateSelected];
//    [button setBackgroundColor:[UIColor blackColor] forState:UIControlStateSelected | UIControlStateHighlighted];
//    [button setBackgroundColor:[UIColor uberGrey120] forState:UIControlStateDisabled];
//    [button setBackgroundColor:[UIColor uberGrey120] forState:UIControlStateDisabled | UIControlStateSelected];
//
//    [button setBorderColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setBorderColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//    [button setBorderColor:[UIColor blackColor] forState:UIControlStateSelected];
//    [button setBorderColor:[UIColor blackColor] forState:UIControlStateSelected | UIControlStateHighlighted];
//    [button setBorderColor:[UIColor uberGrey120] forState:UIControlStateDisabled];
//    [button setBorderColor:[UIColor uberGrey120] forState:UIControlStateDisabled | UIControlStateSelected];
    return button;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_didTapOnLeftBarButtonItem:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame = self.navigationController.navigationBar.frame;
    CGFloat size = frame.size.height - 21;
    CGFloat framePercentageHidden = ((20 - frame.origin.y) / (frame.size.height - 1));
    CGFloat scrollOffset = scrollView.contentOffset.y;
    CGFloat scrollDiff = scrollOffset - self.previousScrollViewYOffset;
    CGFloat scrollHeight = scrollView.frame.size.height;
    CGFloat scrollContentSizeHeight = scrollView.contentSize.height + scrollView.contentInset.bottom;

    if (scrollOffset <= -scrollView.contentInset.top) {
        frame.origin.y = 20;
    } else if ((scrollOffset + scrollHeight) >= scrollContentSizeHeight) {
        frame.origin.y = -size;
    } else {
        frame.origin.y = MIN(20, MAX(-size, frame.origin.y - scrollDiff));
    }
    self.navigationController.navigationBar.alpha =  65.0 / (-scrollOffset);
    [self.navigationController.navigationBar setFrame:frame];
    [self updateBarButtonItems:(1 - framePercentageHidden)];
    self.previousScrollViewYOffset = scrollOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self stoppedScrolling];
    CGFloat scrollOffset = scrollView.contentOffset.y;
    self.navigationController.navigationBar.alpha = 65.0 / (-scrollOffset);

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
    CGFloat scrollOffset = scrollView.contentOffset.y;
    self.navigationController.navigationBar.alpha = 65.0 / (-scrollOffset);

    if (!decelerate) {
        [self stoppedScrolling];
    }
}

- (void)stoppedScrolling
{
    CGRect frame = self.navigationController.navigationBar.frame;
    if (frame.origin.y < 20) {
        [self animateNavBarTo:-(frame.size.height - 21)];
    }
}

- (void)updateBarButtonItems:(CGFloat)alpha
{
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    self.navigationItem.titleView.alpha = alpha;
    self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:alpha];
}

- (void)animateNavBarTo:(CGFloat)y
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.navigationController.navigationBar.frame;
        CGFloat alpha = (frame.origin.y >= y ? 0 : 1);
        frame.origin.y = y;
        [self.navigationController.navigationBar setFrame:frame];
        [self updateBarButtonItems:alpha];
    }];
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

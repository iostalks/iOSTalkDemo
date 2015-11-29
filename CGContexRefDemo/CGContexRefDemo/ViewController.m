//
//  ViewController.m
//  CGContexRefDemo
//
//  Created by Jone on 15/11/24.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import "ViewController.h"
#import "CGContextRefView.h"

@interface ViewController ()

@property (nonatomic, strong) CGContextRefView *refView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refView = [[CGContextRefView alloc] init];
    self.refView.backgroundColor = [UIColor colorWithRed:0.242 green:0.581 blue:0.505 alpha:1.000];
    [self.view addSubview:self.refView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.refView.frame = [[UIScreen mainScreen] bounds];
}

@end

//
//  ViewController.m
//  TabsAnimationTest
//
//  Created by Valentine on 08.09.16.
//  Copyright © 2016 Silvansky. All rights reserved.
//

#import "ViewController.h"

#import "TabBarController.h"

@interface ViewController ()

@property (nonatomic, strong) TabBarController *tabBarController;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.tabBarController = [TabBarController new];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self presentViewController:self.tabBarController animated:NO completion:^{

		}];
	});
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end

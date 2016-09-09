//
//  ColoredViewController.m
//  TabsAnimationTest
//
//  Created by Valentine on 08.09.16.
//  Copyright © 2016 Silvansky. All rights reserved.
//

#import "ColoredViewController.h"

@implementation ColoredViewController

+ (instancetype)coloredViewControllerWithColor:(UIColor *)color
{
	ColoredViewController *instance = [ColoredViewController new];
	instance.view.backgroundColor = color;
	return instance;
}

+ (instancetype)redViewController
{
	ColoredViewController *vc = [self coloredViewControllerWithColor:[UIColor redColor]];
	vc.tabBarItem.title = @"Red";
	vc.tabBarItem.image = [self imageWithColor:[UIColor redColor] size:CGSizeMake(20.f, 20.f)];
	return vc;
}

+ (instancetype)greenViewController
{
	ColoredViewController *vc =  [self coloredViewControllerWithColor:[UIColor greenColor]];
	vc.tabBarItem.title = @"Green";
	vc.tabBarItem.image = [self imageWithColor:[UIColor greenColor] size:CGSizeMake(20.f, 20.f)];
	return vc;
}

+ (instancetype)blueViewController
{
	ColoredViewController *vc =  [self coloredViewControllerWithColor:[UIColor blueColor]];
	vc.tabBarItem.title = @"Blue";
	vc.tabBarItem.image = [self imageWithColor:[UIColor blueColor] size:CGSizeMake(20.f, 20.f)];
	return vc;
}

+ (instancetype)blackViewController
{
	ColoredViewController *vc =  [self coloredViewControllerWithColor:[UIColor blackColor]];
	vc.tabBarItem.title = @"Black";
	vc.tabBarItem.image = [self imageWithColor:[UIColor blackColor] size:CGSizeMake(20.f, 20.f)];
	return vc;
}

+ (instancetype)whiteViewController
{
	ColoredViewController *vc =  [self coloredViewControllerWithColor:[UIColor whiteColor]];
	vc.tabBarItem.title = @"White";
	vc.tabBarItem.image = [self imageWithColor:[UIColor whiteColor] size:CGSizeMake(20.f, 20.f)];
	return vc;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
	CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();

	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end

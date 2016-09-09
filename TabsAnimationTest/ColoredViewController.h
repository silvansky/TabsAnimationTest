//
//  ColoredViewController.h
//  TabsAnimationTest
//
//  Created by Valentine on 08.09.16.
//  Copyright © 2016 Silvansky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColoredViewController : UIViewController

+ (instancetype)coloredViewControllerWithColor:(UIColor *)color;

+ (instancetype)redViewController;
+ (instancetype)greenViewController;
+ (instancetype)blueViewController;
+ (instancetype)blackViewController;
+ (instancetype)whiteViewController;

@end

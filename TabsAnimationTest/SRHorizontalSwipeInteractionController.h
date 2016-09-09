//
//  SRHorizontalSwipeInteractionController.h
//  TabsAnimationTest
//
//  Created by Valentine on 07.09.16.
//  Copyright © 2016 Silvansky. All rights reserved.
//

#import <CEBaseInteractionController.h>

@interface SRHorizontalSwipeInteractionController : CEBaseInteractionController

@property (nonatomic) BOOL popOnRightToLeft;

- (void)prepareGestureRecognizerInView:(UIView *)view;

- (void)wireToViewController:(UIViewController *)viewController;

@end

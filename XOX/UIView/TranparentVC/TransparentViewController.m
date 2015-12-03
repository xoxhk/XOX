//
//  TransparentViewController.m
//  XOX
//
//  Created by xox on 15/12/3.
//  Copyright © 2015年 xox. All rights reserved.
//

#import "TransparentViewController.h"

@interface TransparentViewController ()
@property (strong) UIViewController*  transparentModalViewController;
@end

@implementation TransparentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addNewVC:(id)sender {
    UIViewController* vc = [[UIViewController alloc]init];
    vc.view.backgroundColor =  [UIColor blackColor];
    //[self.view addSubview:vc.view];
    [self presentTransparentModalViewController:vc animated:YES withAlpha:0.5 ];
}
#pragma mark - Transparent Modal View
-(void) presentTransparentModalViewController: (UIViewController *) aViewController
                                     animated: (BOOL) isAnimated
                                    withAlpha: (CGFloat) anAlpha{
    
    self.transparentModalViewController = aViewController;
    UIView *view = aViewController.view;
    
    view.opaque = NO;
    view.alpha = anAlpha;
    [view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *each = obj;
        each.opaque = NO;
        each.alpha = anAlpha;
    }];
    
    if (isAnimated) {
        //Animated
        CGRect mainrect = [[UIScreen mainScreen] bounds];
        CGRect newRect = CGRectMake(0, mainrect.size.height, mainrect.size.width, mainrect.size.height);
        
        
        [self.view addSubview:view];
        view.frame = newRect;
        
        [UIView animateWithDuration:0.8
                         animations:^{
                             view.frame = mainrect;
                         } completion:^(BOOL finished) {
                             //nop
                         }];
        
    }else{
        view.frame = [[UIScreen mainScreen] bounds];
        [self.view addSubview:view];
    }
    
    
    
    
    
    
}

-(void) dismissTransparentModalViewControllerAnimated:(BOOL) animated{
    
    if (animated) {
        CGRect mainrect = [[UIScreen mainScreen] bounds];
        CGRect newRect = CGRectMake(0, mainrect.size.height, mainrect.size.width, mainrect.size.height);
        [UIView animateWithDuration:0.8
                         animations:^{
                             self.transparentModalViewController.view.frame = newRect;
                         } completion:^(BOOL finished) {
                             [self.transparentModalViewController.view removeFromSuperview];
                             self.transparentModalViewController = nil;
                         }];
    }
    
    
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

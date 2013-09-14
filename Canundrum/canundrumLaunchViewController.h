//
//  canundrumLaunchViewController.h
//  Canundrum
//
//  Created by Robert Evans on 27/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
@class decisionsDataController;

@interface canundrumLaunchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) decisionsDataController *dataController;
@end

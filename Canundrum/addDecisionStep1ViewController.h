//
//  decisionsStep1ViewController.h
//  Canundrum
//
//  Created by Robert Evans on 17/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "decision.h"
#import "decisionsDataController.h"

@interface addDecisionStep1ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (strong, nonatomic) decisionsDataController *dataController;
@property (strong) decision *workingDecision;

@end

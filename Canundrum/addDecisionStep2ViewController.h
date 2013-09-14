//
//  decisionsStep2ViewController.h
//  Canundrum
//
//  Created by Robert Evans on 17/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "decision.h"
#import "decisionsDataController.h"

@interface addDecisionStep2ViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;
@property (weak, nonatomic) IBOutlet UITextField *textField5;
@property (weak, nonatomic) IBOutlet UITextField *textField6;
@property (strong, nonatomic) decisionsDataController *dataController;
@property (strong) decision *workingDecision;

@end

//
//  decisionsStep3ViewController.h
//  Canundrum
//
//  Created by Robert Evans on 17/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "decision.h"
#import "decisionsDataController.h"

@interface addDecisionStep3ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UISlider *slider4;
@property (weak, nonatomic) IBOutlet UISlider *slider5;
@property (weak, nonatomic) IBOutlet UISlider *slider6;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (strong, nonatomic) decisionsDataController *dataController;
@property (strong) decision *workingDecision;

@end

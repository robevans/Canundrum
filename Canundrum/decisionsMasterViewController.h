//
//  decisionsMasterViewController.h
//  Canundrum
//
//  Created by Robert Evans on 16/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "decision.h"
#import "editDecisionViewController.h"

@class decisionsDataController;

@interface decisionsMasterViewController: UITableViewController <editDecisionDelegate>
    @property (retain, nonatomic) decisionsDataController *dataController;
@end

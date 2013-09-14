//
//  decisionOptionsTableViewController.h
//  Canundrum
//
//  Created by Robert Evans on 27/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "editOptionViewController.h"

@class decisionsDataController;
@class decision;

@interface optionsTableViewController : UITableViewController <editOptionDelegate>
    @property (retain, nonatomic) decisionsDataController *dataController;
    @property (retain, nonatomic) decision *selectedDecision;
@end

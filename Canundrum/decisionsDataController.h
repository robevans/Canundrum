//
//  decisionsDataController.h
//  Canundrum
//
//  Created by Robert Evans on 27/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import <Foundation/Foundation.h>

@class decision;

@interface decisionsDataController : NSObject

@property (nonatomic, strong) NSMutableArray *masterDecisionsList;

- (NSUInteger)countOfList;
- (decision *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addDecision:(decision *)decision;

@end

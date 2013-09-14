//
//  decision.h
//  Canundrum
//
//  Created by Robert Evans on 27/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import <Foundation/Foundation.h>

@class option;

@interface decision : NSObject <NSMutableCopying>

@property (nonatomic) NSMutableArray *attributesList;
@property (nonatomic) NSMutableArray *weightingsList;
@property (nonatomic) NSMutableArray *sortedOptionsList;
@property (nonatomic) NSString *name;

- (double)percentageScoreOfoption:(option *)option;

@end

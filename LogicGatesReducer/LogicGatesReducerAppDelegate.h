//
//  LogicGatesSolverAppDelegate.h
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 3/16/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogicGatesSolverViewController;
@class TruthTableModel;

@interface LogicGatesReducerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LogicGatesSolverViewController *viewController;
	NSMutableArray *truthTableArray;
}

-(NSMutableArray*) getTruthTable;
-(void) setTruthTable:(NSMutableArray*)array;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LogicGatesSolverViewController *viewController;

@end


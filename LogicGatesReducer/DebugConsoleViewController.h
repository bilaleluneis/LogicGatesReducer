//
//  DebugConsoleViewController.h
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 4/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Quine_McCluskey;
@class LogicGatesReducerAppDelegate;

@interface DebugConsoleViewController : UIViewController {
	
	UIButton *returnButton;
	UITextView *debugConsole;
	
	Quine_McCluskey *qmc;
	LogicGatesReducerAppDelegate *del;

}

@property (nonatomic, retain) IBOutlet UIButton *returnButton;
@property (nonatomic, retain) IBOutlet UITextView *debugConsole;

-(IBAction) return_from_console;

@end

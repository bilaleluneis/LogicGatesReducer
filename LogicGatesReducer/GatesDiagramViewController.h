//
//  GatesDiagramViewController.h
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 3/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GatesDiagramView;


@interface GatesDiagramViewController : UIViewController <UIScrollViewDelegate> {
	UIScrollView *scrollView;
	GatesDiagramView *gatesView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (IBAction) done;

@end

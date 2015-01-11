//
//  GatesDiagramView.h
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 3/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GatesDiagramView : UIView{

}

-(void)drawAndGate:(CGContextRef)con :(int)x :(int)y;
-(void)createAndGateConnection:(CGContextRef)con :(int)x :(int)y;
-(void)drawORGate:(CGContextRef)con :(int)x :(int)y;

@end

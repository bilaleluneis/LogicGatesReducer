//
//  GatesDiagramView.h
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 3/23/10.
//  updated 1/18/2015 to use modern style
//

@import UIKit;


@interface GatesDiagramView : UIView

-(void)drawAndGate:(CGContextRef)con :(int)x :(int)y;
-(void)createAndGateConnection:(CGContextRef)con :(int)x :(int)y;
-(void)drawORGate:(CGContextRef)con :(int)x :(int)y;

@end

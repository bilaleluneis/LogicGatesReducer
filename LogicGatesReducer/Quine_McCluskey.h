//
//  Quine–McCluskey.h
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 4/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TruthTableModel;

@interface Quine_McCluskey : NSObject {
	NSMutableArray *tabularTable;
	NSMutableArray *kmap;
}

-(id)init;
-(void)createTabularTable:(NSMutableArray*) tt;
-(NSString*)displayTabularTable;
-(NSString*) displayKmap;
//-(NSString*) displayMinterms;
-(void)reduceViaQMC;
-(void)reduce;
-(void)finalMinimization;
-(void) markPrimeImp:(TruthTableModel*)tt1 :(TruthTableModel*)tt2;
-(BOOL)differInOneBitOnly :(TruthTableModel*)tt1 :(TruthTableModel*)tt2;
-(NSString*)generateBooleanExpression;
-(int)get_diff_index:(TruthTableModel*)tt1 :(TruthTableModel*)tt2;
-(void)dealloc;
-(void) remove_duplicate_minterms;
//-(void)setBitValue:(char)bit :(int)index;
-(BOOL)minTermExists:(int)minterm :(int)index;
-(void)markIfPrimeImp:(int)index;
@end

//
//  Quine–McCluskey.h
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 4/21/10.
//  updated 1/18/2015
//

#import <Foundation/Foundation.h>

@class TruthTableModel;

@interface Quine_McCluskey : NSObject

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
-(void) remove_duplicate_minterms;
//-(void)setBitValue:(char)bit :(int)index;
-(BOOL)minTermExists:(int)minterm :(int)index;
-(void)markIfPrimeImp:(int)index;
@end

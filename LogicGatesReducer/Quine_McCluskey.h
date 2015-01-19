//
//  Quine–McCluskey.h
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 4/21/10.
//  updated 1/18/2015 to adpot modern syntax
//

#import <Foundation/Foundation.h>

@class TruthTableModel;

@interface Quine_McCluskey : NSObject

-(id)init NS_DESIGNATED_INITIALIZER;
-(void)createTabularTable:(NSMutableArray*) truthTable;
-(NSString*)displayTabularTable;
-(NSString*) displayKmap;
-(void)reduceViaQMC;
-(void)reduce;
-(void)finalMinimization;
-(void) markPrimeImp:(TruthTableModel*)tt1 :(TruthTableModel*)tt2;
-(BOOL)differInOneBitOnly :(TruthTableModel*)tt1 :(TruthTableModel*)tt2;
-(NSString*)generateBooleanExpression;
-(int)get_diff_index:(TruthTableModel*)tt1 :(TruthTableModel*)tt2;
-(void) remove_duplicate_minterms;
-(BOOL)minTermExists:(int)minterm :(int)index;
-(void)markIfPrimeImp:(int)index;

@end

@import Foundation;
@class TruthTableModel;

/**
 @author Bilal El Uneis (bilaleluneis@gmail.com)
 @since 4/21/10 updated 1/19/2015
 @abstract Interface that makes available Quine - McCluskey
 algorithem for Logic Gates Truth Table reduction.
 */

@interface Quine_McCluskey : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (void)createTabularTable:(NSMutableArray*) truthTable;
- (NSString*)displayTabularTable;
- (NSString*) displayKmap;
- (void)reduceViaQMC;
- (void)reduce;
- (void)finalMinimization;
- (void) markPrimeImp:(TruthTableModel*)tt1 :(TruthTableModel*)tt2;
- (BOOL)differInOneBitOnly :(TruthTableModel*)tt1 :(TruthTableModel*)tt2;
- (NSString*)generateBooleanExpression;
- (int)get_diff_index:(TruthTableModel*)tt1 :(TruthTableModel*)tt2;
- (void) remove_duplicate_minterms;
- (BOOL)minTermExists:(int)minterm :(int)index;
- (void)markIfPrimeImp:(int)index;

@end

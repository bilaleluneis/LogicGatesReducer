@import Foundation;

/**
 @author Bilal El Uneis (bilaleluneis@gmail.com)
 @since 4/3/10 updated 1/19/2015
 @abstract Interface to Model Truth Table used to describe logic gates
 functionality.
 */

@interface TruthTableModel : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (void)insertBinaryCell:(int) decimal :(int) numOfIn;
- (void)generateExpression:(char*) bin;
- (int)get_output_value;
- (void)set_output_value :(int)value;
- (void)set_num_of_inputs:(int)value;
- (int)get_num_of_inputs;
- (int)get_decimal_value;
- (void)set_decimal_value:(int)value;
- (void)setBitValue:(char)bit :(int)index;
- (void)set_binary_value:(NSString*)value;
- (NSString*)get_binary_value;
- (void)set_expression:(NSString*)exp;
- (NSString*)get_expression;
- (NSArray*)get_covered_minterms;
- (void)set_covered_minterms:(NSArray*)mintermArray;
- (void)addTo_covered_minterms:(NSArray*)mterm;
- (void)remove_minterm_duplicate;
- (BOOL)get_isCombined;
- (void)set_isCombined:(BOOL)comb;
- (void)setPrimeImpInd:(BOOL)isPrime;
- (BOOL)isPrimeImpInd;

@end

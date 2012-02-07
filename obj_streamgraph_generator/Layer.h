//
//  Layer.h
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import <Foundation/Foundation.h>

@interface Layer : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSArray* size;    //float[]
@property (nonatomic, strong) NSMutableArray* yBottom; //float[]
@property (nonatomic, strong) NSMutableArray* yTop;    //float[]
@property (nonatomic, strong) UIColor* rgb;
@property (assign) int onset;
@property (assign) int end;
@property (assign) float sum;
@property (assign) float volatility;

-(id)initWithName:(NSString*)n AndArray:(NSArray*)siz;

@end

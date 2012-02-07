//
//  ViewController.m
//  obj_streamgraph_demo
//
//  Created by Dominikus Baur on 2/6/12.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "streamgraph_generator.h"
#import "stream_util.h"

@implementation ViewController

int         numLayers     = 50;
int         layerSize     = 100;

float width = 1024.0f;
float height = 768.0f;

NSObject<DataSource>* data;
LayerLayout* layout;
LayerSort* ordering;
NSObject<ColorPicker>* coloring;
NSArray* layers;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    
    // GENERATE DATA
    data     = [[LateOnsetDataSource alloc] init];
    //data     = [[BelievableDataSource alloc] init];
    
    // ORDER DATA
    ordering = [[LateOnsetSort alloc] init];
    //ordering = [[VolatilitySort alloc] init];
    //ordering = [[InverseVolatilitySort alloc] init];
    //ordering = [[BasicLateOnsetSort alloc] init];
    //ordering = [[NoLayerSort alloc] init];
    
    // LAYOUT DATA
    layout   = [[StreamLayout alloc] init];
    //layout   = [[MinimizedWiggleLayout alloc] init];
    //layout   = [[ThemeRiverLayout alloc] init];
    //layout   = [[StackLayout alloc] init];
    
    // COLOR DATA
    coloring = [[LastFMColorPicker alloc] initWithImage:@"layers-nyt.jpg"];
    //coloring = [[LastFMColorPicker alloc] initWithImage:@"layers.jpg"];
    //coloring = [[RandomColorPicker alloc] init];
        
    layers = [data makeWithLayerNum:numLayers AndSizeArrayLength:layerSize];
    layers = [ordering sort:layers];
    [layout layout:layers];
    [coloring colorize:layers];
    
    [self scaleLayers:layers From:1 To:(height - 1)];
        
    //start the drawing
    self.view.layer.delegate = self;
    [self.view.layer setNeedsDisplay];
}


-(void)scaleLayers:(NSArray*)lrs From:(int)screenTop To:(int)screenBottom{
    // Figure out max and min values of layers.
    float min = FLT_MAX;
    float max = FLT_MIN;
    for (int i = 0; i < ((Layer*)[lrs objectAtIndex:0]).size.count; i++) {
        for (int j = 0; j < lrs.count; j++) {
            Layer* l = (Layer*)[lrs objectAtIndex:j];
            min = minf(min, [[l.yTop objectAtIndex:i] floatValue]);
            max = maxf(max, [[l.yBottom objectAtIndex:i] floatValue]);
        }
    }

    float scale = (screenBottom - screenTop) / (max - min);

    for (int i = 0; i < ((Layer*)[layers objectAtIndex:0]).size.count; i++) {
        for (int j = 0; j < layers.count; j++) {
            float nuvalue = screenTop + scale * ([[((Layer*)[layers objectAtIndex:j]).yTop objectAtIndex:i] floatValue] - min);
            [((Layer*)[layers objectAtIndex:j]).yTop replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:nuvalue]];
            nuvalue = screenTop + scale * ([[((Layer*)[layers objectAtIndex:j]).yBottom objectAtIndex:i] floatValue] - min);
            [((Layer*)[layers objectAtIndex:j]).yBottom replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:nuvalue]];        
        }
    }
}


-(void)graphVertex:(CGMutablePathRef)path Point:(int)point Source:(NSMutableArray*)source Pxl:(BOOL)pxl{
    float x = mapf(point, 0, layerSize - 1, 0, width);
    float y = [[source objectAtIndex:point] floatValue] - (pxl ? 1 : 0);
    
    CGPathAddLineToPoint(path, NULL, x, y);
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{   
    int n = layers.count;
    int m = ((Layer*)[layers objectAtIndex:0]).size.count;
    int start;
    int end;
    int lastLayer = n - 1;
    int pxl;

    // generate graph
    for (int i = 0; i < n; i++) {
        Layer* l = (Layer*)[layers objectAtIndex:i];
        start = maxf(0, l.onset - 1);
        end   = minf(m - 1, l.end);
        pxl   = i == lastLayer ? 0 : 1;
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, mapf(start, 0, layerSize - 1, 0, width), [[l.yTop objectAtIndex:start] floatValue] - ((i == lastLayer) ? 1 : 0));
        for (int j = start; j <= end; j++) {
            [self graphVertex:path Point:j Source:l.yTop Pxl:(i == lastLayer)];
        }
        
        // draw bottom edge, right to left
        for (int j = end; j >= start; j--) {
            [self graphVertex:path Point:j Source:l.yBottom Pxl:false];
        }
        CGPathCloseSubpath(path);
        
        CGContextAddPath(ctx, path);
        CGContextSetFillColorWithColor(ctx, l.rgb.CGColor);
        CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
        CGContextDrawPath(ctx, kCGPathFillStroke);
        CFRelease(path);
    }    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end

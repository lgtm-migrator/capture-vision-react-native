//
//  DYSCameraView.m
//  RCTDynamsoftBarcodeReader
//
//  Created by dynamsoft on 2022/3/16.
//

#import "DYSCameraView.h"
#import <React/RCTLog.h>
#import "StaticClass.h"

@implementation DYSCameraView

@synthesize overlayVisible;
@synthesize scanRegionVisible = _scanRegionVisible;
@synthesize scanRegion;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:[StaticClass instance].view];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [StaticClass instance].view.frame = self.bounds;
}

- (void)setOverlayVisible:(BOOL)overlayVisible{
    [StaticClass instance].view.overlayVisible = overlayVisible;
}

- (void)setScanRegionVisible:(BOOL)scanRegionVisible{
    _scanRegionVisible = scanRegionVisible;
    [StaticClass instance].dce.scanRegionVisible = scanRegionVisible;
}

- (BOOL)scanRegionVisible{
    return _scanRegionVisible;
}

- (void)setScanRegion:(NSDictionary *)scanRegion{
    if (scanRegion) {
        NSNumber *regionTop = [scanRegion valueForKey:@"regionTop"];
        NSNumber *regionLeft = [scanRegion valueForKey:@"regionLeft"];
        NSNumber *regionRight = [scanRegion valueForKey:@"regionRight"];
        NSNumber *regionBottom = [scanRegion valueForKey:@"regionBottom"];
        NSNumber *regionMeasuredByPercentage = [scanRegion valueForKey:@"regionTop"];
        iRegionDefinition *region = [iRegionDefinition new];
        region.regionTop = regionTop.integerValue;
        region.regionLeft = regionLeft.integerValue;
        region.regionRight = regionRight.integerValue;
        region.regionBottom = regionBottom.integerValue;
        region.regionMeasuredByPercentage = regionMeasuredByPercentage.boolValue;
        NSError *err = [NSError new];
        [[StaticClass instance].dce setScanRegion:region error:&err];
        [StaticClass instance].dce.scanRegionVisible = _scanRegionVisible;
    }
}

- (void)open{
    [[StaticClass instance].dce open];
}

- (void)close{
    [[StaticClass instance].dce close];
}

@end

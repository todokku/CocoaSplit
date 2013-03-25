//
//  h264Compressor.h
//  streamOutput
//
//  Created by Zakk on 3/17/13.
//  Copyright (c) 2013 Zakk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import "FFMpegTask.h"

@class CaptureController;

@protocol h264Compressor <NSObject>

//compressFrame is expected to be non-blocking. Create a serial dispatch queue if the underlying compressor
//is blocking
//frame_data should be free()-able, compressor will free when required
-(bool)compressFrame:(CVImageBufferRef)imageBuffer pts:(CMTime)pts duration:(CMTime)duration;

-(bool)setupCompressor;


@property (strong) CaptureController *settingsController;
@property (strong) CaptureController *outputDelegate;





@end

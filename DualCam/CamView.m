#import "CamView.h"

@implementation CamView

- (instancetype)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.wantsLayer = YES;
		
		captureSession = [[AVCaptureSession alloc] init];
		camList = [[NSMenu alloc] init];
		
		// with higher quality, the streams sometimes get out of sync with reality.
		//      for our purposes, latency is more important than quality. 
		captureSession.sessionPreset = AVCaptureSessionPresetLow;
		
		NSArray* devs = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
		for (id dev in devs) {
			if ([dev isKindOfClass:[AVCaptureDevice class]]) {
				AVCaptureDevice *device = (AVCaptureDevice*)dev;
				NSMenuItem* entry = [[NSMenuItem alloc] initWithTitle:[device localizedName] action:@selector(setCamera:) keyEquivalent:@""];
				entry.representedObject = device;
				entry.target = self;
				[camList addItem:entry];
			}
		}
		
		self.menu = camList;
	}
	return self;
}

- (void)setCamera:(id)sender {
	if ([[sender representedObject] isKindOfClass:[AVCaptureDevice class]]) {
		AVCaptureDevice* camDev = (AVCaptureDevice*)[sender representedObject];
		[self showCamera:camDev];
	}
}

-(void)setup {
	previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
	previewLayer.frame = [self bounds];
	[[self layer] addSublayer:previewLayer];
}

-(void)showCamera:(AVCaptureDevice*)dev {
	[captureSession stopRunning];
	
	for (id i in [captureSession inputs]) {
		if ([i isKindOfClass:[AVCaptureInput class]]) {
			AVCaptureInput* input = (AVCaptureInput*)i;
			[captureSession removeInput:input];
		}
	}
	AVCaptureDeviceInput* cap = [AVCaptureDeviceInput deviceInputWithDevice:dev error:nil];
	[captureSession addInput:cap];
	
	previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	
	[captureSession startRunning];
}

@end

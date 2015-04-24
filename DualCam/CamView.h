#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>


@interface CamView : NSView {
	@public AVCaptureSession* captureSession;
	AVCaptureVideoPreviewLayer* previewLayer;
	NSMenu* camList;
}

-(void)setCamera:(id)sender;
-(void)setup;
-(void)showCamera:(AVCaptureDevice*)dev;

@end

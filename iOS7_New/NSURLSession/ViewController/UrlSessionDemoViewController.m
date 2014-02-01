//
//  UrlSessionDemoViewController.m
//  iOS7_New
//
//  Created by lincoln.liu on 2/1/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import "UrlSessionDemoViewController.h"

@interface UrlSessionDemoViewController ()

@end

@implementation UrlSessionDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.progressBar.progress = 0;
}


- (NSURLSession *)session
{
    //创建NSURLSession
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    return session;
}

- (NSURLRequest *)request
{
    //创建请求
    NSURL *url = [NSURL URLWithString:@"http://p1.pichost.me/i/40/1639665.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}

-(IBAction)start:(id)sender
{
    //用NSURLSession和NSURLRequest创建网络任务
    self.task = [[self session] downloadTaskWithRequest:[self request]];
    [self.task resume];
}

-(IBAction)pause:(id)sender
{
    NSLog(@"Pause download task");
    if (self.task) {
        //取消下载任务，把已下载数据存起来
        [self.task cancelByProducingResumeData:^(NSData *resumeData) {
            self.partialData = resumeData;
            self.task = nil;
        }];
    }
}

-(IBAction)resume:(id)sender
{
    NSLog(@"resume download task");
    if (!self.task) {
        //判断是否又已下载数据，有的话就断点续传，没有就完全重新下载
        if (self.partialData) {
            self.task = [[self session] downloadTaskWithResumeData:self.partialData];
        }else{
            self.task = [[self session] downloadTaskWithRequest:[self request]];
        }
    }
    [self.task resume];
}

//创建文件本地保存目录
-(NSURL *)createDirectoryForDownloadItemFromURL:(NSURL *)location
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = urls[0];
    return [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
}
//把文件拷贝到指定路径
-(BOOL) copyTempFileAtURL:(NSURL *)location toDestination:(NSURL *)destination
{

    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:destination error:NULL];
    [fileManager copyItemAtURL:location toURL:destination error:&error];
    if (error == nil) {
        return true;
    }else{
        NSLog(@"%@",error);
        return false;
    }
}

#pragma mark NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    //下载成功后，文件是保存在一个临时目录的，需要开发者自己考到放置该文件的目录
    NSLog(@"Download success for URL: %@",location.description);
    NSURL *destination = [self createDirectoryForDownloadItemFromURL:location];
    BOOL success = [self copyTempFileAtURL:location toDestination:destination];
    
    if(success){
//        文件保存成功后，使用GCD调用主线程把图片文件显示在UIImageView中
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithContentsOfFile:[destination path]];
            self.imageView.image = image;
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            self.imageView.hidden = NO;
        });
    }else{
        NSLog(@"Meet error when copy file");
    }
    self.task = nil;
}

/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //刷新进度条的delegate方法，同样的，获取数据，调用主线程刷新UI
    double currentProgress = totalBytesWritten/(double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressBar.progress = currentProgress;
        self.progressBar.hidden = NO;
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

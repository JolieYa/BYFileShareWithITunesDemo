//
//  ViewController.h
//  BYFileShareWithITunesDemo
//
//  Created by gongairong on 2017/12/12.
//  Copyright © 2017年 xinghaiwulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end


@interface FileModel:NSObject
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *filePath;

@end

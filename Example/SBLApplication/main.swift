//
//  main.swift
//  SBLApplication
//
//  Created by Takuya Otani on 03/17/2017.
//  Copyright (c) 2017 Takuya Otani / SerendipityNZ Ltd. All rights reserved.
//

import SBLApplication

UIApplicationMain(
  CommandLine.argc,
  UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self,
                                                             capacity: Int(CommandLine.argc)),
  NSStringFromClass(SBLApplication.self),
  NSStringFromClass(AppDelegate.self)
)

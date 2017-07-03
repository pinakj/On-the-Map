//
//  GCDBlackBox.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/1/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import Foundation


func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}

//
//  TaskCellUpdating.swift
//  TasksApp
//
//  Created by zombietux on 13/02/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import Foundation

protocol TaskCellUpdating {
    func onTextViewChanged(text: String, object: Any?)
}

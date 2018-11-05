//
//  ToDo.swift
//  toDo
//
//  Created by Stephanie Fong on 11/3/18.
//  Copyright © 2018 Stephanie Fong. All rights reserved.
//

import Foundation

class Task
{
    var title: String
    var done: Bool

    public init(title: String)
    {
        self.title = title
        self.done = false
    }
}

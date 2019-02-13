//
//  Task.swift
//  TasksApp
//
//  Created by zombietux on 08/02/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import Foundation
import RealmSwift

class Task:Object {
    @objc dynamic var text = ""
    @objc dynamic var created = Date()
    @objc dynamic var completed = false
    
    static func getAllTasks() -> Results<Task> {
        return try! Realm().objects(Task.self)
    }
    
    static func makeTask(text: String, completed: Bool = false) -> Task {
        let task = Task()
        task.text = text
        task.completed = completed
        
        return task
    }
    
    static func makePersistedTask() -> Task? {
        let task = Task()
        
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(task)
            }
        } catch {
            print("Realm error while attempting to save Task object!")
            return nil
        }
        
        
        return task
    }
    
    func setText(_ text: String) {
        do {
            try Realm().write {
                self.text = text
            }
        } catch {
            print("Error while writing...")
        }
    }
    
    func setCompleted(_ completed: Bool) {
        do {
            try Realm().write {
                self.completed = completed
            }
            
        } catch {
            print("Error while writing...")
        }
    }
    
    func delete() {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.delete(self)
            }
        } catch {
            print("Error while writing")
        }
    }
}



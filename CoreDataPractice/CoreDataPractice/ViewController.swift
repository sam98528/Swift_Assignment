//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by Sam.Lee on 4/10/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var persistentContainer : NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        saveData()
//        updateData()
//        deleteData()
//        readData()

        // Do any additional setup after loading the view.
    }


    // 데이터 쓰기 (Create)
    func saveData(){
        guard let context = self.persistentContainer?.viewContext else {return}
        
        let newCar = Car(context : context)
        newCar.id = UUID()
        newCar.name = "Benz"
        
        try? context.save()
    }
    
    // 데이터 읽기 (Read)
    func readData(){
        guard let context = self.persistentContainer?.viewContext else {return}
        let request = Car.fetchRequest()
        let cars = try? context.fetch(request)
        
        print(cars)
    }
    
    
    // 데이터 수정 (Update)
    func updateData(){
        guard let context = self.persistentContainer?.viewContext else {return}
        
        let request = Car.fetchRequest()
        guard let cars = try? context.fetch(request) else {return}
        
        let filteredCars = cars.filter{$0.name == "Benz"}
        
        for car in filteredCars {
            car.name = "tesla"
        }
        
        try? context.save()
    }
    
    // 데이터 삭제 (Delete)
    
    func deleteData(){
        guard let context = self.persistentContainer?.viewContext else {return}
        let request = Car.fetchRequest()
        guard let cars = try? context.fetch(request) else {return}
        let filteredCars = cars.filter{$0.name == "tesla"}
        
        for car in filteredCars {
            context.delete(car)
        }
        try? context.save()
    }
}


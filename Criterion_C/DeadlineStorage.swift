//
//  EventStorage.swift
//  Criterion_C
//
//  Created by Twexcx on 21/09/2025.
//

import Foundation

class DeadlineStorage: ObservableObject {
    @Published var deadlines: [LocalDeadline] = []
    private let fileName = "deadlines.json"
    
    init()
    {
        loadDeadlines()
    }
    
    private func fileURL() -> URL?
    {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent(fileName)
    }
    
    func loadDeadlines()
    {
        guard let url = fileURL() else {return}
        do{
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            deadlines = try decoder.decode([LocalDeadline].self, from: data)
            
        }
        catch
        {
            deadlines = []
        }
    }
    
    func saveDeadlines()
    {
        guard let url = fileURL() else {return}
        do
        {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(deadlines)
            try data.write(to: url)
        }
        catch
        {
            print("Failed to save deadlines: \(error)")
        }
    }
    
    func addOrUpdateDeadline (_ deadline: LocalDeadline)
    {
        if let index = deadlines.firstIndex(where: {$0.id == deadline.id})
        {
            deadlines[index] = deadline //update
        }
        else
        {
            deadlines.append(deadline)
        }
        deadlines.sort(by: {$0.startDate < $1.startDate})
        saveDeadlines()
    }
    
    func deleteDeadline(_ deadline: LocalDeadline){
        deadlines.removeAll {$0.id == deadline.id}
        saveDeadlines()
    }
}

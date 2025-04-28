//
//  HealthInformationManager.swift
//  GO
//
//  Created by 최승범 on 4/15/25.
//

import Foundation
import HealthKit

struct HealthInformationManager {
    
    private let healthStore = HKHealthStore()
    // 읽기 및 쓰기 권한 설정
    let read: Set<HKSampleType> = [
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
        HKObjectType.quantityType(forIdentifier: .dietaryWater)!
    ]

    let share: Set<HKSampleType> = [
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
        HKObjectType.quantityType(forIdentifier: .dietaryWater)!
    ]
   
    
    //MARK: -  권한 요청
    func configure() {
        // 해당 장치가 healthkit을 지원하는지 여부
        if HKHealthStore.isHealthDataAvailable() {
            requestAuthorization()
        }
    }
    
    private func requestAuthorization() {
        self.healthStore.requestAuthorization(toShare: share, read: read) { success, error in
            if error != nil {
                LogManager.log(error.debugDescription)
            }else{
                if success {
                    LogManager.log("권한이 허락되었습니다")
                }else{
                    LogManager.log("권한이 없습니다")
                }
            }
        }
    }
    
    // 심박수 가져오기
    func fetchHeartRate(completion: @escaping ([Double]) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion([])
            return
        }
        
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: heartRateType,
                                  predicate: nil,
                                  limit: 100,
                                  sortDescriptors: [sortDescriptor]) { (query, results, error) in
            guard error == nil else {
                print("Error fetching heart rate: \(error!.localizedDescription)")
                completion([])
                return
            }
            
            let heartRates = results?.compactMap { sample -> Double? in
                guard let quantitySample = sample as? HKQuantitySample else { return nil }
                // 심박수는 'count/min' 단위로 저장되어 있음
                return quantitySample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
            } ?? []
            
            completion(heartRates)
        }
        
        healthStore.execute(query)
    }
    
}

extension HealthInformationManager {
    func fetchStepCount(start: Date, end: Date) async throws -> [Int] {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            throw HealthError.typeNotFound
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
        
        return try await withCheckedThrowingContinuation { continuation in
            let interval = DateComponents(day: 1)
            
            let query = HKStatisticsCollectionQuery(
                quantityType: stepType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum,
                anchorDate: start,
                intervalComponents: interval
            )
            
            query.initialResultsHandler = { _, results, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let statsCollection = results else {
                    continuation.resume(returning: [])
                    return
                }
                
                var stepsPerDay: [Int] = []
                statsCollection.enumerateStatistics(from: start, to: end) { statistics, _ in
                    if let sum = statistics.sumQuantity() {
                        let stepCount = Int(sum.doubleValue(for: HKUnit.count()))
                        stepsPerDay.append(stepCount)
                    } else {
                        stepsPerDay.append(0)
                    }
                }
                continuation.resume(returning: stepsPerDay)
            }
            
            healthStore.execute(query)
        }
    }
}

extension HealthInformationManager {
    
    enum HealthError: Error {
           case typeNotFound
       }
}

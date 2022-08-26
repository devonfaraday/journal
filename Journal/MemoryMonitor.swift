//
//  MemoryMonitor.swift
//  Journal
//
//  Created by Christian McMullin on 4/26/22.
//

import Foundation

struct MemoryMonitor {
    func reportMemory() {
        var taskInfo = task_vm_info_data_t()
        var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4
        let result: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
            }
        }
        let usedMb = Float(taskInfo.phys_footprint) / 1048576.0
        let totalMb = Float(ProcessInfo.processInfo.physicalMemory) / 1048576.0
        result != KERN_SUCCESS ? print("Memory used: ? of \(totalMb)") : print("Memory used: \(usedMb) of \(totalMb)")
    }
}

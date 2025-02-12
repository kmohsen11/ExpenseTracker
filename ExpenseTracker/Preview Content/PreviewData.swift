//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Khaled Mohsen on 31/05/2024.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "Desjardins", account:"Visa Desjardins", merchant: "Apple",
                                         amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)



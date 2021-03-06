//
//  ProspectView.swift
//  Project_16_HotProspects
//
//  Created by Blaine Dannheisser on 3/25/22.
//

import CodeScanner
import SwiftUI
import UserNotifications

// MARK: - ProspectView

struct ProspectsView: View {

    // 3a) We want all instances of Prospects View to read that object back out of the enviornment when they are created. Find the object, attach to a prperty, and keep it up to date over time.
    @EnvironmentObject var prospects: Prospects

    enum Filtertype {
        case none, contacted, uncontacted
    }

    let filter: Filtertype

    enum SortType {
        case name, date
    }

    @State private var sorting = SortType.date

    @State private var isShowingScanner = false
    @State private var showingConfirmation = false

    var body: some View {
        NavigationView {
            List {
                // Challenge 3: Use a confirmation dialog to customize users are sorted in each tab.
                ForEach(filteredProspects.sorted {
                    sorting == .name ? ($0.name < $1.name) : ($0.dateAdded < $1.dateAdded ) }) { prospect in
                    //Challenge 1: Add icon to "Everyone Screen" showing whether they have been contacted or not
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()

                        prospect.isContacted ? Image(systemName: "person.crop.circle.fill.badge.checkmark") : Image(systemName: "person.fill.xmark")
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.red.opacity(0.7))
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green.opacity(0.7))

                            Button  {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind me tomorrow", systemImage: "bell")
                            }
                            .tint(.orange.opacity(0.7))
                        }
                    }
                }
            }
            .confirmationDialog("Sort Option", isPresented: $showingConfirmation) {
                Button("By Name") { sorting = .name }
                Button("By Date Added") { sorting = .date }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingConfirmation.toggle()
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down.square")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowingScanner = true
                        } label: {
                            Label("Scan", systemImage: "qrcode.viewfinder")
                        }
                    }
                }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Monk\nmonk@us.gov", completion: handleScan)
            }
        }
    }
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted"
        case .uncontacted:
            return "Uncontacted"
        }
    }

    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")

            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)
        case .failure(let error):
            print("Scaning failed: \(error.localizedDescription)")
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Not authorizing notifications")
                    }
                }
            }
        }
    }
}

// MARK: - ProspectView_Previews

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())

    }
}

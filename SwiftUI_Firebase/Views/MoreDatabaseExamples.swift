import SwiftUI
import FirebaseDatabase

// Updated Event model without status and superBowl
struct Event: Identifiable {
    let id: String
    let name: String
    let date: String
    let description: String
    let location: String
    let participants: [String]
    
    // Decode from Firebase dictionary
    init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? "Unknown Event"
        self.date = data["date"] as? String ?? "Unknown Date"
        self.description = data["description"] as? String ?? "No description available"
        self.location = data["location"] as? String ?? "Unknown Location"
        self.participants = data["participants"] as? [String] ?? []
    }
}

struct MoreDatabaseExamples: View {
    // State to hold the decoded event and saved UUID
    @State private var decodedEvent: Event?
    @State private var statusMessage: String = ""
    @State private var savedEventUUID: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Firebase Database Examples")
                .font(.title)
                .padding()
            
            Button(action: {
                writeEventToFirebase()
            }) {
                Text("Write Event to Firebase")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                Task {
                    await readEventFromFirebase()
                }
            }) {
                Text("Read Event from Firebase")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(savedEventUUID == nil)
            
            // Display decoded event or status
            if let event = decodedEvent {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Event ID: \(event.id)")
                        .font(.subheadline)
                    Text("Name: \(event.name)")
                        .font(.headline)
                    Text("Date: \(event.date)")
                        .font(.subheadline)
                    Text("Description: \(event.description)")
                        .font(.body)
                    Text("Location: \(event.location)")
                        .font(.subheadline)
                    Text("Participants:")
                        .font(.subheadline)
                        .bold()
                    ForEach(event.participants, id: \.self) { participant in
                        Text("• \(participant)")
                            .font(.body)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            } else {
                Text(statusMessage)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
    }
    
    // Function to write the simplified event to Firebase
    func writeEventToFirebase() {
        let eventUUID = UUID().uuidString // Generate UUID
        let eventsRef = Database.database().reference().child("events")
        let eventRef = eventsRef.child(eventUUID)
        
        let eventData: [String: Any] = [
            "name": "Philadelphia Eagles Super Bowl LIX Victory Parade",
            "date": "2025-02-14",
            "description": "A celebration of the Eagles' Super Bowl LIX win with a parade through Philadelphia.",
            "location": "Broad Street to Philadelphia Museum of Art",
            "participants": [
                "Philadelphia Eagles Team",
                "Mayor of Philadelphia",
                "Eagles Cheerleaders",
                "Swoop (Mascot)"
            ]
        ]
        
        eventRef.setValue(eventData) { (error, _) in
            if let error = error {
                statusMessage = "Failed to write: \(error.localizedDescription)"
            } else {
                savedEventUUID = eventUUID // Save the UUID
                statusMessage = "Wrote event with UUID: \(eventUUID)"
            }
        }
    }
    
    // Async function to read and decode the event from Firebase
    func readEventFromFirebase() async {
        guard let uuid = savedEventUUID else {
            statusMessage = "No event UUID saved to read"
            decodedEvent = nil
            return
        }
        
        guard let data = try? await Database.database().reference().child("events/\(uuid)").getData() else {
            statusMessage = "Failed to fetch event data"
            decodedEvent = nil
            return
        }
        
        guard let dictionary = data.value as? [String: Any] else {
            statusMessage = "Failed to cast event data to dictionary"
            decodedEvent = nil
            return
        }
        
        let event = Event(id: uuid, data: dictionary)
        decodedEvent = event
        statusMessage = "Successfully read event"
    }
}

// Preview provider
#Preview {
    MoreDatabaseExamples()
}

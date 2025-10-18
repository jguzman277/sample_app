import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    console.log("Connected to notifications channel")
  },

  disconnected() {
    console.log("Disconnected from notifications channel")
  },

  received(data) {
    console.log("Received notification:", data)
    // Handle the notification here
    // For example, update a notification badge or show a toast
  }
})
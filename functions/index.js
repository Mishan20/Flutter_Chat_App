const {onDocumentCreated, onDocumentUpdated} = require(
    "firebase-functions/v2/firestore");
const admin = require("firebase-admin");
admin.initializeApp();

// Trigger for when a document is updated in Conversations/{user1}/List/{user2}
exports.sendNotificationWhenUpdate = onDocumentUpdated(
    {
      document: "Conversations/{user1}/List/{user2}",
      region: "us-central1",
    },
    (event) => {
      const data = event.data.after;
      return handleNotification(data, event.params.user2);
    },
);

// Trigger for when a document is created in Conversations/{user1}/List/{user2}
exports.sendNotificationWhenCreate = onDocumentCreated(
    {
      document: "Conversations/{user1}/List/{user2}",
      region: "us-central1",
    },
    (event) => {
      const newData = event.data;
      return handleNotification(newData, event.params.user2);
    },
);

// Handle notification function
// eslint-disable-next-line require-jsdoc
function handleNotification(data, uid) {
  if (uid !== data.sendBy.uid) {
    console.log("Notification sent");
    const payload = {
      notification: {
        title: data.sendBy.name,
        body: data.lastMessage,
      },
      data: {
        uid: data.sendBy.uid,
        name: data.sendBy.name,
        image: data.sendBy.image,
        token: data.sendBy.token,
      },
      token: data.user.token,
    };
    return admin.messaging().send(payload);
  }
  return Promise.resolve();
}

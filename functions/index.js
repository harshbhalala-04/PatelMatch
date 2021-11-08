// import * as admin from "firebase-admin";
// import * as functions from "firebase-functions";

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();
const fieldValue = admin.firestore.FieldValue;

exports.onUserCreate = functions.firestore
  .document("/users/{uid}")
  .onCreate(async (snapshot, context) => {
    try {
      const statsRef = db.collection("STATS").doc("ADMIN_STATS");
      const newUserStats = {
        totalUsers: fieldValue.increment(1),
      };
      console.log(newUserStats);
      await statsRef.update(newUserStats);
      return "User Created Successfully";
    } catch (e) {
      console.log(e);
      return "Error";
    }
  });


exports.onMessageCreate = functions.firestore
  .document("chatroom/{chatRoomId}/chats/{chatId}")
  .onCreate(async (snapshot, context) => {
    try {
      const chatData = snapshot.data();
      const tokens = [];
      const userRef = db.collection("users").doc(chatData["otherUserUid"]);
      const userData = await userRef.get();
      if (userData.data()["notificationTokens"] != undefined &&
        userData.data()["notificationTokens"].length != 0) {
        userData.data()["notificationTokens"]
          .forEach((token) => {
            tokens.push(token);
          });
      }
      const payLoadData = {
        click_action: "FLUTTER_NOTIFICATION_CLICK",
        title: "You Have Recieved a Message from Someone",
        message: "Tap To View",
        screen: "message_screen",
      };
      const payload = {
        data: payLoadData,
      };
      await admin.messaging()
        .sendToDevice(tokens, payload)
        .then((response) => {
          console.log("push user request notification");
        })
        .catch((err)=>{
          console.log(err);
        });
    } catch (e) {
      console.log(e);
      return "Error";
    }
  });

exports.onUserUpdate = functions.firestore
  .document("/users/{userId}")
  .onUpdate(async (snapshot, context) => {
    try {
      const oldUserData = snapshot.before.data();
      const newUserData = snapshot.after.data();
      const newUserGender = newUserData["gender"];
      const newUserWeight = newUserData["weight"];
      const statsRef = db.collection("STATS").doc("ADMIN_STATS");
      if (newUserWeight == undefined) {
        const newUserStats = {
          totalMaleUsers: newUserGender == "Male" ?
            fieldValue.increment(1) : fieldValue.increment(0),
          totalFemaleUsers: newUserGender == "Female" ?
            fieldValue.increment(1) : fieldValue.increment(0),
        };
        console.log("Enters in if block");
        console.log(newUserStats);
        await statsRef.update(newUserStats);
      }

      if (oldUserData["latestConnectionSentUid"]!=
      newUserData["latestConnectionSentUid"]) {
        const userRef = db.collection("users")
          .doc(newUserData["latestConnectionSentUid"]);
        const userData = await userRef.get();

        const tokens = [];
        if (userData.data()["notificationTokens"] != undefined &&
        userData.data()["notificationTokens"].length != 0) {
          userData.data()["notificationTokens"]
            .forEach((token) => {
              tokens.push(token);
            });
        }
        const payLoadData = {
          click_action: "FLUTTER_NOTIFICATION_CLICK",
          title: "You Have Recieved a Request",
          message: "Tap To View",
          screen: "custom_tab_bar",
        };
        const payload = {
          data: payLoadData,
        };

        await admin.messaging()
          .sendToDevice(tokens, payload)
          .then((response) => {
            console.log("push user request notification");
          })
          .catch((err)=>{
            console.log(err);
          });
      }
      return "User Updated Successfully";
    } catch (e) {
      console.log(e);
      return "Error";
    }
  });

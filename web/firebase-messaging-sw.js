importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

// Beta config
//firebase.initializeApp({
// apiKey: "AIzaSyAwMUfdb3LjuJ7i4w6zZSLCREUTmP8iaWc",
//   authDomain: "truvideo---beta.firebaseapp.com",
//   projectId: "truvideo---beta",
//   storageBucket: "truvideo---beta.appspot.com",
//   messagingSenderId: "391143604655",
//   appId: "1:391143604655:web:98c83dddfe52ca87b7ef5a",
//   measurementId: "G-47XFB9VE1F"
//});

// Vegas config
firebase.initializeApp({
  apiKey: "AIzaSyD2q1spNNzb-Gko3LKpVUsK2Pq-ABnhaDo",
   authDomain: "truvideo-demo-vegas.firebaseapp.com",
   projectId: "truvideo-demo-vegas",
   storageBucket: "truvideo-demo-vegas.appspot.com",
   messagingSenderId: "821955577133",
   appId: "1:821955577133:web:a63b8ce45a1835106e7fa4"
});


// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});
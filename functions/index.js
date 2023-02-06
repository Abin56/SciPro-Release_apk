const functions = require("firebase-functions");
const Razorpay = require("razorpay");
const crypto = require("crypto");


// let key_id ='rzp_live_WkqZiZtSI6LGQ9';
// let key_secret ='EQ9HnZE8uskkg71cHLytnzOm';

const razorpay = new Razorpay({
  key_id: functions.config().razorpay.key_id,
  key_secret: functions.config().razorpay.key_secret,
  });


  exports.createOrder = functions.https.onCall(async (data, context) => {
    try {
      const order = await razorpay.orders.create({
        amount: data.amount,
        currency: data.currency,
        receipt: data.receipt,
        notes: {
          description: data.description,
        },
      });
      return order;
    } catch (err) {
      console.error(`${err}`);
      throw new functions.https.HttpsError(
          "aborted",
          "Could not create the order",
      );
    }
  });


  exports.verifySignature = functions.https.onCall(async (data, context) => {
    const hmac = crypto.createHmac(
        "sha256",
        functions.config().razorpay.key_secret,
    );
    hmac.update(data.orderId + "|" + data.paymentId);
    const generatedSignature = hmac.digest("hex");
    const isSignatureValid = generatedSignature == data.signature;
    return isSignatureValid;
  });

// const functions = require("firebase-functions");

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


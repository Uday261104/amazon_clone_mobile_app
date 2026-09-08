const express = require("express");
const dotenv = require("dotenv");
const mongoose = require("mongoose");

dotenv.config();

const app = express();

app.use(express.json());

app.use((req, res, next) => {
  console.log(`→ ${req.method} ${req.url}`);
  res.on("finish", () => {
    console.log(`← ${res.statusCode} ${req.method} ${req.url}`);
    console.log(res);
  });
  next();
});

// Import auth router
const auth = require("./routes/auth");

// Register auth routes
app.use(auth);

mongoose
  .connect(process.env.MONGO_URI)
  .then(() => {
    console.log("MongoDB connected successfully");

    app.listen(3000, "0.0.0.0", () => {
      console.log("Server running on port 3000");
    });
  })
  .catch((error) => {
    console.log("MongoDB connection failed:", error.message);
  });
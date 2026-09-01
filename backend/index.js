const express = require("express");
const dotenv = require("dotenv");

dotenv.config();

const connectDB = require("./config/db");

const app = express();

connectDB();

const dash = require("./routes/dash");

// const auth = require("./routes/auth");

app.use(dash);

// app.use(auth);

const PORT = 3000;

app.listen(PORT, () => {
    console.log("Server running on port no 3000");
});
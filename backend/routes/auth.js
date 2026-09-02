const express = require("express");
const User = require("../models/user");
const bcrypt=require("bcryptjs");

const authRouter = express.Router();

authRouter.post("/api/sign-up", async (req, res) => {

    // Receive Data
    const { email, name, password } = req.body;

    // Validation
    if (!email || !name || !password) {
        return res.status(400).json({
            msg: "Please provide all required fields."
        });
    }

    // Check if user already exists
    const exist = await User.findOne({ email });

    if (exist) {
        return res.status(400).json({
            msg: "User already exists."
        });
    }

    const hashPassword=await bcrypt.hash(password,10);
    // Create user
    const user = new User({
        name,
        email,
        password:hashPassword
    });

    // Save to database
    await user.save();

    return res.status(201).json({
        msg: "User created successfully",
        user
    });
});

module.exports = authRouter;
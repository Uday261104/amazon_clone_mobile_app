const express = require("express");
const User = require("../models/user");
const bcrypt=require("bcryptjs");
const jwt = require('jsonwebtoken');
const auth=require('../middlewares/auth');
const authRouter = express.Router();

authRouter.post("/api/sign-up", async (req, res) => {
    try {
        const { email, name, password } = req.body;

        if (!email || !name || !password) {
            return res.status(400).json({
                msg: "Please provide all required fields."
            });
        }

        const exist = await User.findOne({ email });

        if (exist) {
            return res.status(400).json({
                msg: "User already exists."
            });
        }

        const hashPassword = await bcrypt.hash(password, 10);
        const user = new User({
            name,
            email,
            password: hashPassword
        });

        await user.save();

        return res.status(201).json({
            msg: "User created successfully",
            user
        });
    } catch (error) {
        return res.status(500).json({ error: error.message });
    }
});


authRouter.post("/api/sign-in",async(req,res)=>{
    try{
        const {email,password}=req.body;

        const user = await User.findOne({ email });

        if (!user) {
            return res.status(400).json({
                msg: "User doesnot exists."
            });
        }

        const isMatching=await bcrypt.compare(password, user.password)

        if(!isMatching){
            return res.status(400).json({
                msg:"Incorrect Password"
            })
        }

        //JSON WEB TOKEN
        const token=jwt.sign({id:user._id},"secretkey");
        res.json({token,...user._doc});

    }catch(error){
        return res.status(500).json({error:error.message})
    }
})

authRouter.post("/api/validate-token", async (req, res) => {
  try {
    const token = req.header("token");

    if (!token) {
      return res.json(false);
    }

    const isValid = jwt.verify(token, "secretKey");

    if (!isValid) {
      return res.json(false);
    }

    const user = await User.findById(isValid.id);

    if (!user) {
      return res.json(false);
    }

    return res.json(true);
  } catch (e) {
    console.log(e);
    return res.json(false);
  }
});


authRouter.get("/",auth,async(req,res)=>{

    const user=await User.findOne(req.user);
    res.json({...user._doc,token:req.token})

})

module.exports = authRouter;
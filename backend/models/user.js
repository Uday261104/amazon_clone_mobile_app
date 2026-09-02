const moongoose=require('mongoose');

const userSchema=moongoose.Schema({
    name:{
        required:true,
        type:String,
        trim:true,
    },

    email: {
    type: String,
    required: true,
    trim:true,
    validate: {
        validator: (value) => {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
        },
        message: "Please enter a valid email"
    }
    },

    password: {
    required: true,
    type: String,
    validate: {
        validator: (value) => {
            return value.length >= 6;
        },
        message: "Password must be at least 6 characters long."
    }
    },

    address:{
        type:String,
        default:''
    },

    type:{
        type:String,
        default:'user'
    },


});

const User = moongoose.model("User", userSchema);

module.exports = User;
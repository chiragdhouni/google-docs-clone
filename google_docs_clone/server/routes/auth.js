const express = require('express');
const authRouter = express.Router();
const mongoose = require('mongoose');
const User = require("../models/user");

authRouter.post("/api/signup", async (req, res) => {
    const { name, email, profilePic } = req.body;
    try {
        let user = await User.findOne({ email: email });
        if (!user) {
            user = new User({
                name: name,
                email: email,
                profilePic: profilePic
            });
            user = await user.save();
            res.status(200).json({user});
        }
    } catch (error) {
        res.status(500).json(`some error occurred ${error}`);
    }
});

module.exports =authRouter; 
const express=require('express');
const mongoose=require('mongoose');
const authRouter = require("./routes/auth");
const cors=require("cors");


const app=express();
const PORT=process.env.PORT | 3000;
const DB="mongodb+srv://chiragdhouni20:chiragdhouni20@cluster0.8htryyp.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
app.use(cors());
app.use(express.json());    
app.use(authRouter);
mongoose.connect(DB).then(  ()    =>  console.log("connection successful"))
app.listen(PORT,'0.0.0.0',()=>{
    console.log(`Server is running on port ${PORT}`);
});
import express from 'express';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import User from '../models/User.js';

const router = express.Router();

// for tregister
router.post('/register', async (req, res) => {
   const { name, username, phone, email, password } = req.body;
   try {
      const userExists = await User.findOne({ 
         $or: [{ email }, { username }, { phone }]
      });

      if (userExists) return res.status(400).json({ msg: "User already exists" });

      const hashedPassword = await bcrypt.hash(password, 10);
      const newUser = new User({ name, username, phone, email, password: hashedPassword });

      await newUser.save();
      res.status(201).json({ msg: "User registered successfully" });
   } catch (err) {
      res.status(500).json({ msg: "Server error" });
   }
});

// lkogin can be by email, username, or phone
router.post('/login', async (req, res) => {
   const { identifier, password } = req.body; // identifier can be email, username, or phone
   try {
      const user = await User.findOne({ 
         $or: [{ email: identifier }, { username: identifier }, { phone: identifier }]
      });

      if (!user) return res.status(400).json({ msg: "Invalid credentials" });

      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) return res.status(400).json({ msg: "Invalid credentials" });

      const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: "1h" });

      res.json({ 
         token, 
         user: { 
            id: user._id, 
            name: user.name, 
            username: user.username, 
            email: user.email, 
            phone: user.phone 
         } 
      });
   } catch (err) {
      res.status(500).json({ msg: "Server error" });
   }
});

export default router;

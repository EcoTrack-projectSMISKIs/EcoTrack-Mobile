import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';
import dotenv from 'dotenv';
import authRoutes from './routes/authRoutes.js';

dotenv.config();

const mongoURI = process.env.MONGO_URI;
if (!mongoURI) {
    console.error("ERROR: MONGO_URI is undefined. Check your .env file!");
    process.exit(1);
}

mongoose.connect(mongoURI)
   .then(() => console.log("MongoDB Connected"))
   .catch(err => console.error("MongoDB Connection Error:", err));

const app = express();
app.use(cors());
app.use(express.json());

app.use('/api/auth', authRoutes);

const PORT = process.env.PORT || 5001;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

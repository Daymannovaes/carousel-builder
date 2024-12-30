import { Router } from 'express';

const router = Router();

router.get('/ping', (req, res) => {
    const timestamp = new Date().toISOString();
    console.log(`[${timestamp}] Received ping request from frontend`);
    res.json({ message: 'pong' });
});

export default router;

import 'dotenv/config';
import express from 'express';
import cors from 'cors';

const app = express();
app.use(cors());
app.use(express.json({ limit: '1mb' }));
app.get('/api/health', (_req, res) => res.json({ service: 'archilife-central', status: 'ok' }));
app.get('/api/dashboard/summary', (_req, res) => res.json({ branches: 0, salesToday: 0, revenueToday: '0.00', pendingEvents: 0 }));
app.get('/api/products', (_req, res) => res.json([]));
app.post('/api/sync/events', (_req, res) => res.status(501).json({ message: 'Sync endpoint pending implementation' }));

const port = Number(process.env.PORT || 4000);
app.listen(port, () => console.log(`Central API listening on ${port}`));

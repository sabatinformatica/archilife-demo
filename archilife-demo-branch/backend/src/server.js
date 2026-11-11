import 'dotenv/config';
import express from 'express';
import cors from 'cors';

const app = express();
app.use(cors());
app.use(express.json({ limit: '1mb' }));
app.get('/api/health', (_req, res) => res.json({ service: 'archilife-branch', status: 'ok', branchId: process.env.BRANCH_ID || 'NOT_CONFIGURED' }));
app.get('/api/products', (_req, res) => res.json([]));
app.get('/api/sales', (_req, res) => res.json([]));
app.post('/api/sales', (_req, res) => res.status(501).json({ message: 'Sales endpoint pending implementation' }));
app.get('/api/sync/status', (_req, res) => res.json({ connection: 'unknown', pending: 0, failed: 0, lastSyncAt: null }));

const port = Number(process.env.PORT || 3001);
app.listen(port, () => console.log(`Branch API listening on ${port}`));

import express from 'express';
import createPool from '../db.js';

const router = express.Router();
const pool = await createPool();

// Get all items
router.get('/', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM items');
    res.json(rows);
  } catch (err) {
    console.error('Database error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Create new item
router.post('/', async (req, res) => {
  const { name } = req.body;
  if (!name) return res.status(400).json({ error: 'Name is required' });
  
  try {
    const [result] = await pool.query(
      'INSERT INTO items (name) VALUES (?)',
      [name]
    );
    res.status(201).json({ id: result.insertId, name });
  } catch (err) {
    console.error('Create error:', err);
    res.status(500).json({ error: 'Failed to create item' });
  }
});

export default router;

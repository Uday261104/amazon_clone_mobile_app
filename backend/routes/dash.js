const express = require('express');

const dash = express.Router();

dash.get('/dashboard', (req, res) => {
    res.json({ "data": "5000k" });
});

module.exports = dash;
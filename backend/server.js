const express = require("express");
const bodyParser = require("body-parser");
const db = require("./db");

const app = express();
app.use(bodyParser.json());

app.get("/", (req, res) => {
  res.send("🚀 Enterprise DevOps Project with SQL DB is running!");
});

// Get all users
app.get("/users", async (req, res) => {
  try {
    const [rows] = await db.query("SELECT * FROM users");
    res.json(rows);
  } catch (err) {
    res.status(500).send(err);
  }
});

// Add new user
app.post("/users", async (req, res) => {
  const { name, email } = req.body;
  try {
    await db.query("INSERT INTO users (name, email) VALUES (?, ?)", [name, email]);
    res.send("✅ User added successfully");
  } catch (err) {
    res.status(500).send(err);
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

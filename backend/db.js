const mysql = require("mysql2/promise");

const db = mysql.createPool({
  host: process.env.DB_HOST || "mysql",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "rootpass",
  database: process.env.DB_NAME || "devopsdb",
});

module.exports = db;

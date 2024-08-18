const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");

const app = express();
app.use(bodyParser.json());

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "restaurante",
});

db.connect((err) => {
  if (err) throw err;
  console.log("Conectado a la base de datos MySQL");
});

// Rutas para clientes
app.post("/clientes", (req, res) => {
  const { cedula, nombre, apellido, correo, contrasenia, telefono } = req.body;
  const sql =
    "INSERT INTO clientes (cedula, nombre, apellido, correo, contrasenia, telefono) VALUES (?, ?, ?, ?, ?, ?)";
  db.query(
    sql,
    [cedula, nombre, apellido, correo, contrasenia, telefono],
    (err, result) => {
      if (err) throw err;
      res.send("Cliente registrado");
    }
  );
});

// Rutas para restaurantes
app.post("/restaurantes", (req, res) => {
  const {
    nombre,
    horario,
    metodos_pago,
    metodos_entrega,
    correo,
    contrasenia,
    telefono,
  } = req.body;
  const sql =
    "INSERT INTO restaurantes (nombre, horario, metodos_pago, metodos_entrega, correo, contrasenia, telefono) VALUES (?, ?, ?, ?, ?, ?, ?)";
  db.query(
    sql,
    [
      nombre,
      horario,
      metodos_pago,
      metodos_entrega,
      correo,
      contrasenia,
      telefono,
    ],
    (err, result) => {
      if (err) throw err;
      res.send("Restaurante registrado");
    }
  );
});

// Rutas para pedidos
app.post("/pedidos", (req, res) => {
  const { cliente_id, metodo_pago, tipo_envio, detalles } = req.body;
  const sql =
    "INSERT INTO pedidos (cliente_id, metodo_pago, tipo_envio, detalles) VALUES (?, ?, ?, ?)";
  db.query(
    sql,
    [cliente_id, metodo_pago, tipo_envio, detalles],
    (err, result) => {
      if (err) throw err;
      res.send("Pedido registrado");
    }
  );
});

// Rutas para el menú
app.post("/menu", (req, res) => {
  const {
    numero_almuerzos,
    sopas,
    plato_fuerte,
    postres,
    jugos,
    ensaladas,
    extras,
  } = req.body;
  const sql =
    "INSERT INTO menu (numero_almuerzos, sopas, plato_fuerte, postres, jugos, ensaladas, extras) VALUES (?, ?, ?, ?, ?, ?, ?)";
  db.query(
    sql,
    [numero_almuerzos, sopas, plato_fuerte, postres, jugos, ensaladas, extras],
    (err, result) => {
      if (err) throw err;
      res.send("Menú registrado");
    }
  );
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});

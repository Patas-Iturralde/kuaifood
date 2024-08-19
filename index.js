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

app.get("/clientes/:cedula", (req, res) => {
  const { cedula } = req.params;
  const sql = "SELECT * FROM clientes WHERE cedula = ?";
  db.query(sql, [cedula], (err, result) => {
    if (err) throw err;
    res.send(result);
  });
});

app.put("/clientes/:cedula", (req, res) => {
  const { cedula } = req.params;
  const { nombre, apellido, correo, contrasenia, telefono } = req.body;
  const sql =
    "UPDATE clientes SET nombre = ?, apellido = ?, correo = ?, contrasenia = ?, telefono = ? WHERE cedula = ?";
  db.query(
    sql,
    [nombre, apellido, correo, contrasenia, telefono, cedula],
    (err, result) => {
      if (err) throw err;
      res.send("Cliente actualizado");
    }
  );
});

app.delete("/clientes/:cedula", (req, res) => {
  const { cedula } = req.params;
  const sql = "DELETE FROM clientes WHERE cedula = ?";
  db.query(sql, [cedula], (err, result) => {
    if (err) throw err;
    res.send("Cliente eliminado");
  });
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

app.get("/restaurantes/:id", (req, res) => {
  const { id } = req.params;
  const sql = "SELECT * FROM restaurantes WHERE id = ?";
  db.query(sql, [id], (err, result) => {
    if (err) throw err;
    res.send(result);
  });
});

app.put("/restaurantes/:id", (req, res) => {
  const { id } = req.params;
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
    "UPDATE restaurantes SET nombre = ?, horario = ?, metodos_pago = ?, metodos_entrega = ?, correo = ?, contrasenia = ?, telefono = ? WHERE id = ?";
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
      id,
    ],
    (err, result) => {
      if (err) throw err;
      res.send("Restaurante actualizado");
    }
  );
});

app.delete("/restaurantes/:id", (req, res) => {
  const { id } = req.params;
  const sql = "DELETE FROM restaurantes WHERE id = ?";
  db.query(sql, [id], (err, result) => {
    if (err) throw err;
    res.send("Restaurante eliminado");
  });
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

app.get("/pedidos/:id", (req, res) => {
  const { id } = req.params;
  const sql = "SELECT * FROM pedidos WHERE id = ?";
  db.query(sql, [id], (err, result) => {
    if (err) throw err;
    res.send(result);
  });
});

app.put("/pedidos/:id", (req, res) => {
  const { id } = req.params;
  const { cliente_id, metodo_pago, tipo_envio, detalles } = req.body;
  const sql =
    "UPDATE pedidos SET cliente_id = ?, metodo_pago = ?, tipo_envio = ?, detalles = ? WHERE id = ?";
  db.query(
    sql,
    [cliente_id, metodo_pago, tipo_envio, detalles, id],
    (err, result) => {
      if (err) throw err;
      res.send("Pedido actualizado");
    }
  );
});

app.delete("/pedidos/:id", (req, res) => {
  const { id } = req.params;
  const sql = "DELETE FROM pedidos WHERE id = ?";
  db.query(sql, [id], (err, result) => {
    if (err) throw err;
    res.send("Pedido eliminado");
  });
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

app.get("/menu/:id", (req, res) => {
  const { id } = req.params;
  const sql = "SELECT * FROM menu WHERE id = ?";
  db.query(sql, [id], (err, result) => {
    if (err) throw err;
    res.send(result);
  });
});

app.put("/menu/:id", (req, res) => {
  const { id } = req.params;
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
    "UPDATE menu SET numero_almuerzos = ?, sopas = ?, plato_fuerte = ?, postres = ?, jugos = ?, ensaladas = ?, extras = ? WHERE id = ?";
  db.query(
    sql,
    [
      numero_almuerzos,
      sopas,
      plato_fuerte,
      postres,
      jugos,
      ensaladas,
      extras,
      id,
    ],
    (err, result) => {
      if (err) throw err;
      res.send("Menú actualizado");
    }
  );
});

app.delete("/menu/:id", (req, res) => {
  const { id } = req.params;
  const sql = "DELETE FROM menu WHERE id = ?";
  db.query(sql, [id], (err, result) => {
    if (err) throw err;
    res.send("Menú eliminado");
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});

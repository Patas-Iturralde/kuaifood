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


app.post("/login", (req, res) => {
  const { correo, contrasenia } = req.body;

  // Consultar en la tabla clientes
  const clienteQuery = "SELECT * FROM clientes WHERE correo = ? AND contrasenia = ?";
  db.query(clienteQuery, [correo, contrasenia], (err, clienteResult) => {
    if (err) throw err;

    if (clienteResult.length > 0) {
      // Si el usuario es cliente
      return res.send({ mensaje: "cliente", usuario: clienteResult[0] });
    } else {
      // Si no es cliente, revisar en restaurantes
      const restauranteQuery = "SELECT * FROM restaurantes WHERE correo = ? AND contrasenia = ?";
      db.query(restauranteQuery, [correo, contrasenia], (err, restauranteResult) => {
        if (err) throw err;

        if (restauranteResult.length > 0) {
          // Si el usuario es restaurante
          return res.send({ mensaje: "restaurante", usuario: restauranteResult[0] });
        } else {
          // Si no se encuentra en ninguna tabla
          return res.status(401).send({ mensaje: "Credenciales inválidas" });
        }
      });
    }
  });
});


// Rutas para clientes
app.post("/clientes", (req, res) => {
  const { cedula, nombre, apellido, correo, contrasenia, telefono } = req.body;
  const sql = "INSERT INTO clientes (cedula, nombre, apellido, correo, contrasenia, telefono) VALUES (?, ?, ?, ?, ?, ?)";
  db.query(sql, [cedula, nombre, apellido, correo, contrasenia, telefono], (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error al registrar el cliente");
    } else {
      res.send("Cliente registrado");
    }
  });
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
    metodos_pago, // Combina los métodos de pago seleccionados
    metodos_entrega, // Combina los métodos de entrega seleccionados
    correo,
    contrasenia,
    telefono,
  } = req.body;

  const sql = "INSERT INTO restaurantes (nombre, horario, metodos_pago, metodos_entrega, correo, contrasenia, telefono) VALUES (?, ?, ?, ?, ?, ?, ?)";

  db.query(sql, [nombre, horario, metodos_pago, metodos_entrega, correo, contrasenia, telefono], (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error al registrar el restaurante");
    } else {
      res.send("Restaurante registrado");
    }
  });
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
    metodo_pago_efectivo,
    metodo_pago_transferencia,
    metodo_entrega_domicilio,
    metodo_entrega_local,
    correo,
    contrasenia,
    telefono,
  } = req.body;
  const sql =
    "UPDATE restaurantes SET nombre = ?, horario = ?, metodo_pago_efectivo = ?, metodo_pago_transferencia = ?, metodo_entrega_domicilio = ?, metodo_entrega_local = ?, correo = ?, contrasenia = ?, telefono = ? WHERE id = ?";
  db.query(
    sql,
    [
      nombre,
      horario,
      metodo_pago_efectivo,
      metodo_pago_transferencia,
      metodo_entrega_domicilio,
      metodo_entrega_local,
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
    fecha
  } = req.body;
  const sql =
    "INSERT INTO menu (numero_almuerzos, sopas, plato_fuerte, postres, jugos, ensaladas, extras, fecha) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
  db.query(
    sql,
    [numero_almuerzos, sopas, plato_fuerte, postres, jugos, ensaladas, extras, fecha],
    (err, result) => {
      if (err) throw err;
      res.send("Menú registrado");
    }
  );
});


app.get("/menu", (req, res) => {
  const { fecha } = req.query;  // Se espera que la fecha llegue como query param
  console.log("Fecha recibida:", fecha); // Imprime la fecha recibida
  const sql = "SELECT * FROM menu WHERE fecha = ?";
  db.query(sql, [fecha], (err, result) => {
    if (err) throw err;
    console.log("Resultados de la consulta:", result); // Imprime los resultados obtenidos
    res.send(result);
  });
});



// Actualizar solo el número de almuerzos
app.put("/menu/:id", (req, res) => {
  const { id } = req.params;
  const { numero_almuerzos } = req.body;

  // Consulta SQL para actualizar solo el número de almuerzos
  const sql = "UPDATE menu SET numero_almuerzos = ? WHERE id = ?";

  db.query(sql, [numero_almuerzos, id], (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).send({ mensaje: "Error al actualizar el número de almuerzos" });
    } else {
      res.status(200).send({ mensaje: "Número de almuerzos actualizado correctamente" });
    }
  });
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

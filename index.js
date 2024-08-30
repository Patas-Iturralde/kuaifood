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

app.use(
  session({
    key: "userId",
    secret: "ProjectLD",
    resave: false,
    saveUninitialized: false,
    cookie: {
      expires: 60 * 60 * 24,
    },
  })
);

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
    metodo_pago_efectivo,
    metodo_pago_transferencia,
    metodo_entrega_domicilio,
    metodo_entrega_local,
    correo,
    contrasenia,
    telefono,
  } = req.body;
  const sql =
    "INSERT INTO restaurantes (nombre, horario, metodo_pago_efectivo, metodo_pago_transferencia, metodo_entrega_domicilio, metodo_entrega_local, correo, contrasenia, telefono) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
    sopa,
    plato_fuerte,
    postre,
    jugo,
    ensalada,
    extra1,
  } = req.body;
  const sql =
    "INSERT INTO menu (numero_almuerzos, sopa, plato_fuerte, postre, jugo, ensalada, extra1) VALUES (?, ?, ?, ?, ?, ?, ?)";
  db.query(
    sql,
    [numero_almuerzos, sopa, plato_fuerte, postre, jugo, ensalada, extra1],
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
    sopa,
    plato_fuerte,
    postre,
    jugo,
    ensalada,
    extra1,
  } = req.body;
  const sql =
    "UPDATE menu SET numero_almuerzos = ?, sopa = ?, plato_fuerte = ?, postre = ?, jugo = ?, ensalada = ?, extra1 = ? WHERE id = ?";
  db.query(
    sql,
    [numero_almuerzos, sopa, plato_fuerte, postre, jugo, ensalada, extra1, id],
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

/**Login Auth */
app.get("/login", (req, res) => {
  if (req.session.correo) {
    res.send({ loggedIn: true, user: req.session.correo });
  } else {
    res.send({ loggedIn: false });
  }
});

app.post("/login", (req, res) => {
  const correo = req.body.mail;
  const contrasenia = req.body.pass;
  db.query("SELECT * FROM usuario WHERE mail = ?", mail, (err, result) => {
    var string = JSON.stringify(result);
    //console.log('>> string: ', string );
    var json = JSON.parse(string);
    console.log(json[0]);
    if (err) {
      res.send({ err: err });
    }

    if (result.length > 0) {
      if (pass === json[0].pass) {
        req.session.mail = result;
        console.log(result);
        res.send(result);
      } else {
        res.send({ message: "Usuario o contraseña incorrectos" });
      }
    } else {
      res.send({ message: "Usuario no existe" });
    }
  });
});

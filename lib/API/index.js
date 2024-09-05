const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");
const bcrypt = require("bcrypt");
const { body, validationResult } = require("express-validator");

const app = express();
app.use(bodyParser.json());

// Conexión a la base de datos MySQL
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "restaurante",
});

db.connect((err) => {
  if (err) {
    console.error("Error al conectar a la base de datos:", err);
    process.exit(1); // Termina la aplicación si hay un error al conectar
  }
  console.log("Conectado a la base de datos MySQL");
});

// Rutas para clientes
app.post(
  "/clientes",
  [
    body("cedula").isLength({ min: 10 }).withMessage("Cédula no válida"),
    body("nombre").notEmpty().withMessage("El nombre es obligatorio"),
    body("correo").isEmail().withMessage("Correo no válido"),
    body("contrasenia")
      .isLength({ min: 8 })
      .withMessage("La contraseña debe tener al menos 6 caracteres"),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { cedula, nombre, apellido, correo, contrasenia, telefono } =
      req.body;
    try {
      const hashedPassword = await bcrypt.hash(contrasenia, 10);
      const sql =
        "INSERT INTO clientes (cedula, nombre, apellido, correo, contrasenia, telefono) VALUES (?, ?, ?, ?, ?, ?)";
      db.query(
        sql,
        [cedula, nombre, apellido, correo, hashedPassword, telefono],
        (err, result) => {
          if (err) {
            return res.status(500).send("Error al registrar cliente");
          }
          res.send("Cliente registrado");
        }
      );
    } catch (err) {
      res.status(500).send("Error en el servidor");
    }
  }
);

// Rutas para restaurantes
app.post(
  "/restaurantes",
  [
    body("nombre").notEmpty().withMessage("El nombre es obligatorio"),
    body("correo").isEmail().withMessage("Correo no válido"),
    body("contrasenia")
      .isLength({ min: 8 })
      .withMessage("La contraseña debe tener al menos 6 caracteres"),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const {
      nombre,
      horario,
      metodos_pago,
      metodos_entrega,
      correo,
      contrasenia,
      telefono,
    } = req.body;
    try {
      const hashedPassword = await bcrypt.hash(contrasenia, 10);
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
          hashedPassword,
          telefono,
        ],
        (err, result) => {
          if (err) {
            return res.status(500).send("Error al registrar restaurante");
          }
          res.send("Restaurante registrado");
        }
      );
    } catch (err) {
      res.status(500).send("Error en el servidor");
    }
  }
);

// Rutas para pedidos
app.post(
  "/pedidos",
  [
    body("cliente_id").isNumeric().withMessage("Cliente ID debe ser numérico"),
    body("metodo_pago")
      .notEmpty()
      .withMessage("El método de pago es obligatorio"),
    body("tipo_envio")
      .notEmpty()
      .withMessage("El tipo de envío es obligatorio"),
  ],
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { cliente_id, metodo_pago, tipo_envio, detalles } = req.body;
    const sql =
      "INSERT INTO pedidos (cliente_id, metodo_pago, tipo_envio, detalles) VALUES (?, ?, ?, ?)";
    db.query(
      sql,
      [cliente_id, metodo_pago, tipo_envio, detalles],
      (err, result) => {
        if (err) {
          return res.status(500).send("Error al registrar pedido");
        }
        res.send("Pedido registrado");
      }
    );
  }
);

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

// Puerto
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});

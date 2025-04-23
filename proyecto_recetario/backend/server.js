const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const app = express();
const PORT = 12346;

// Middleware para procesar JSON
app.use(bodyParser.json());

// Ruta para manejar la solicitud POST
app.post('/maintenances', (req, res) => {
  const newMaintenance = req.body;
  console.log(req.body);

  // Leer el archivo JSON existente
  fs.readFile('maintenances.json', 'utf8', (err, data) => {
    if (err) {
      console.error('Error al leer el archivo JSON:', err);
      return res.status(500).json({ message: 'Error al leer el archivo' });
    }

    let maintenances = [];
    if (data) {
      maintenances = JSON.parse(data); // Parsear el contenido existente
    }

    // Agregar el nuevo mantenimiento
    maintenances.push(newMaintenance);

    // Guardar los datos actualizados en el archivo JSON
    fs.writeFile('maintenances.json', JSON.stringify(maintenances, null, 2), (err) => {
      if (err) {
        console.error('Error al escribir en el archivo JSON:', err);
        return res.status(500).json({ message: 'Error al guardar el mantenimiento' });
      }

      res.status(201).json({ message: 'Mantenimiento guardado con éxito' });
    });
  });
});

// Ruta para manejar la solicitud GET
app.get('/maintenances', (req, res) => {
  fs.readFile('maintenances.json', 'utf8', (err, data) => {
    if (err) {
      console.error('Error al leer el archivo JSON:', err);
      return res.status(500).json({ message: 'Error al leer el archivo' });
    }

    // Parsear el contenido del archivo JSON o devolver un array vacío si está vacío
    const maintenances = JSON.parse(data || '[]');
    res.status(200).json(maintenances); // Responder con los datos en formato JSON
  });
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://10.0.2.2:${PORT}`);
});
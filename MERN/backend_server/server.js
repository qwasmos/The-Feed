const express = require('express')
const mongoose = require('mongoose')
const cors = require('cors')
require('dotenv').config()

// *=== Setup Express App ===* //
const app = express()

app.use(cors());
app.use(express.json()); // for any request to express server,
                        // checks if request already carries important data

// *=== Connect to MongoDB ===* //
mongoose.connect('mongodb://localhost/MERN')
  .then(() => {
    console.log('Connected to MongoDB')

    // *=== Start the Express Server ===* //
    const PORT = process.env.PORT || 5000;  // Use the port from the .env file or default to 5000
    app.listen(PORT, () => {
        console.log(`Server is running on port ${PORT}`);
      })
  })
  .catch(error => {
    console.error(error)
  });

// routes and middleware
const users = require('./routes/users');
const services = require('./routes/services');
const bookings = require('./routes/bookings');

app.use('/users', users) // only fires "users" routes when comes to /users path
app.use('/services', services)
app.use('/bookings', bookings)
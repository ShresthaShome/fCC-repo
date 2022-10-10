// index.js
// where your node app starts

// init project
var express = require('express');
var app = express();

// enable CORS (https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)
// so that your API is remotely testable by FCC 
var cors = require('cors');
app.use(cors({optionsSuccessStatus: 200}));  // some legacy browsers choke on 204

// http://expressjs.com/en/starter/static-files.html
app.use(express.static('public'));

// http://expressjs.com/en/starter/basic-routing.html
app.get("/", function (req, res) {
  res.sendFile(__dirname + '/views/index.html');
});


// your first API endpoint... 

function dater(rDate) {
  if((rDate != null) && (/^-?\d+$/.test(rDate))) rDate = parseInt(rDate);
  var date = (rDate != null)? new Date(rDate) : new Date();
  var unixT = date.getTime();
  if (unixT != unixT) {
    return { error : "Invalid Date" };
  }
  return {unix: unixT, utc: date.toUTCString()};
}

app.get("/api/hello", function (req, res) {
  res.json({greeting: 'hello API'});
});

app.get('/api/:Date?', (req, res) => {
  var rDate = req.params.Date;
  res.json(dater(rDate));
});

// listen for requests :)
var listener = app.listen(process.env.PORT, function () {
  console.log('Your app is listening on port ' + listener.address().port);
});

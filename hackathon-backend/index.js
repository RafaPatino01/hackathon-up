const express = require('express')
const app = express()
const port = 3000
const mysql = require('mysql');
var crypto = require('crypto');
const https = require('https');

const puppeteer = require('puppeteer');
const jsdom = require('jsdom');

//------------ String cleanup
String.prototype.cleanup = function() {
  return this.toLowerCase().replace(/[^a-zA-Z0-9]+/g, "-");
}

// ------------- DATABASE
var db_config = {
	host:"110.238.83.6",
	user:"root",
	password: "Tomiko@2022",
	database:"hackathon-up"
};

var connection;

function handleDisconnect() {
	connection = mysql.createConnection(db_config); // Recreate the connection, since
													// the old one cannot be reused.

	connection.connect(function(err) {              // The server is either down
		if(err) {                                     // or restarting (takes a while sometimes).
			console.log('[ERR] error when connecting to db:', err);
			setTimeout(handleDisconnect, 2000); // We introduce a delay before attempting to reconnect,
		}
		else {
			console.log("[OK] Database server running...");
		}                                     // to avoid a hot loop, and to allow our node script to
	});                                     // process asynchronous requests in the meantime.
											// If you're also serving http, display a 503 error.
	connection.on('error', function(err) {
		console.log('[ERR] DB disconected...');
		if(err.code === 'PROTOCOL_CONNECTION_LOST') { // Connection to the MySQL server is usually
			handleDisconnect();                         // lost due to either server restart, or a
		} else {                                      // connnection idle timeout (the wait_timeout
			throw err;                                  // server variable configures this)
		}
	});
}

handleDisconnect();


// --------------- ENDPOINTS ------------


app.get('/', (req, res) => {
  res.send('Hello World!')
})

// GET CITIES FROM DATABASE
app.get('/get_terminales', function(req, res) {

  console.log('[INFO] Getting terminales from SQL database')  

	const sql = 'SELECT * FROM terminales';

	connection.query(sql,(err,result)=>{
		if(err){
			//throw err;
			res.send('{"error":"no_result"}');
		}
		if(result.length > 0) {
			res.json(result);
		}
		else {
			res.send('{"error":"no_result"}');
		}
	});
});


app.get('/login', function(req, res) {

  console.log('[INFO] User loging in')  

  let user = req.query.user_name
  var og_string = req.query.password;
  var hash = crypto.createHash('md5').update(og_string).digest('hex');

	const sql = 'SELECT * FROM users WHERE username="'+user+'"';

	connection.query(sql,(err,result)=>{
		if(err){
			//throw err;
			res.send('{"error":"no_result"}');
		}
		if(result.length > 0) {
      if(result[0]["password"] == hash){
        res.send(["OK"]);
      }
		}
		else {
			res.send('{"error":"no_result"}');
		}
	});
});

// new user to DB
app.get('/add_user', function (req, res) {

	console.log('[INFO] Recieved user: ' + typeof(req.query.user_name))
  console.log('[INFO] Recieved pass: ' + typeof(req.query.password))  
  console.log('[INFO] Adding USER to DB')  
  
  var og_string = req.query.password;
  var hash = crypto.createHash('md5').update(og_string).digest('hex');
  console.log("hashing password: " + hash);

	const sql = 'INSERT INTO users SET ?';

	const postObject = {
		username: req.query.user_name,
		password: hash
	}

	connection.query(sql, postObject, (err, result)=> {
		if(err) {
			throw err;
		}
		else {
			res.send(["OK"]);
    }
  })
})



app.get('/scraper', (req, res) => {

  // Scrapping the website
  (async () => {
    console.log('Recieved scrapper request: ' + typeof(req.query.link))

    // Launch the browser
    const browser = await puppeteer.launch({
      executablePath: '/usr/bin/chromium-browser',
      headless:true,
      args: ["--no-sandbox"]
    })
    
    // Create a page
    const page = await browser.newPage();
 
    // Go to your site
    //await page.goto('https://www.clickbus.com.mx/es/buscar/celaya-gto-(todas-las-terminales)/ciudad-de-mexico-df-(todas-las-terminales)/?isGroup=&ida=2023-04-30&volta=#/step/departure');
    let url = req.query.link
    await page.goto(url);
    
    const lista_resultados = await page.$$('.search-results-list')
 
    //const ejemplo = await lista_resultados[0].evaluate(el => el.textContent)
    const trip_data = await lista_resultados[0].$$(".trip-data")

    console.log("[INFO] Resultados obtenidos: " + trip_data.length)

    let resultado = []
    for(let i = 0; i<trip_data.length; i++){

      let dict = new Object();
      let temp = ""

      dict["id"] = i
      // Company
      let company = await trip_data[i].$$(".company")
      temp = await company[0].evaluate(el => el.textContent)
      temp = temp.cleanup().replaceAll('-', ' ')
      dict["company"] = temp

      // Hour
      let hour = await trip_data[i].$$(".hour")
      temp = await hour[0].evaluate(el => el.textContent)
      temp = temp.cleanup().replaceAll('-', ' ')
      dict["hour"] = temp

      //bus-stations
      let bus_stations = await trip_data[i].$$(".bus-stations")
      temp = await bus_stations[0].evaluate(el => el.textContent)
      temp = temp.cleanup().replaceAll('-', ' ')
      dict["bus_stations"] = temp

      //duration
      let duration = await trip_data[i].$$(".duration")
      temp = await duration[0].evaluate(el => el.textContent)
      temp = temp.cleanup().replaceAll('-', ' ')
      dict["duration"] = temp

      //price
      let price = await trip_data[i].$$(".price")
      temp = await price[0].evaluate(el => el.textContent)
      temp = temp.cleanup().replaceAll('-', ' ')
      dict["price"] = temp.replace("seleccionar","").replace("desde", "").replace("mxn", "$")

      console.log(dict)
      resultado.push(dict)
      console.log("------------------------------")

    }

    // Close browser.
    await browser.close()

    res.send(resultado)

  })()

})

app.listen(port, () => {
  console.log(`[INFO] Backend hackaton app listening on port ${port}`)
})

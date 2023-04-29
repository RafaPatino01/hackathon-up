const express = require('express')
const app = express()
const port = 3000
const mysql = require('mysql');
var crypto = require('crypto');
const https = require('https');

const puppeteer = require('puppeteer');
const jsdom = require('jsdom');


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

// GET FROM DATABASE
app.get('/get_test', function(req, res) {

	const sql = 'SELECT * FROM example';

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

			res.json(result[0]["password"] == hash);
		}
		else {
			res.send('{"error":"no_result"}');
		}
	});
});

//POST new user to DB
app.post('/add_user', function (req, res) {

	console.log('Recieved: ' + typeof(req.query.user_name))
  console.log('Recieved: ' + typeof(req.query.password))  
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
			res.send("[OK]");
    }
  })
})



app.get('/scraper', (req, res) => {

  (async () => {
    // Launch the browser
    const browser = await puppeteer.launch();

    // Create a page
    const page = await browser.newPage();

    // Go to your site
    await page.goto('https://stackoverflow.com/questions/5878682/node-js-hash-string');

    // Query for an element handle.
    /*
    const element = await page.waitForSelector('.question-hyperlink');

    const title = await element.evaluate(el => el.textContent);

    console.log(title)
    * */

    const text = await page.$$('.question-hyperlink')
 
    console.log(text[0].evaluate(el => el.textContent))

    // Dispose of handle
    //await element.dispose();

    // Close browser.
    await browser.close();
  })();

  res.send("[OK]")
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
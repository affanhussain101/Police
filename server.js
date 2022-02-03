const express = require('express');
const mysql = require('mysql');
const bodyParser = require("body-parser");
const app = express();

app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static('public'));

app.set('views', './views');
app.set('view engine', 'ejs');


var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database:"DBMSP"
});

con.connect(function(err) {
  if (err) throw err;
  else
  console.log("Connected!");
});

// app.get('', function (req, res) {
//   res.render(__dirname+"/views/Login.ejs");
// })

//Password authentication

var loginStatus=false;

app.get('/', (req, res) => {
  if(!loginStatus){
    res.render("login")
  }
  else{
    res.render("Main")
  }
})

app.post("/", (req,res)=>{
  username=req.body.username
  password=req.body.password
  con.query(`SELECT PASSWORD FROM police WHERE police_id="${username}"`,function(error,results){
    if(error || results[0]==undefined){
      console.log(error);
      res.redirect("/")
    }
    else{
      console.log(results[0].PASSWORD);
      if(results[0].PASSWORD==password){
        loginStatus=true
        res.redirect("/Main")
      }
      else
      res.redirect("/");
      
    }
  })
})

app.get("/logout", (req,res)=>{
  loginStatus=false;
  res.redirect("/");
})

//pushing data into the database

// app.get('/Signup', (req, res) => {
//   res.render('Signup',{ title: 'Signup' });
//  });
app.get('/Signup', function(req, res, next) {
  var sql='SELECT * FROM station';
  con.query(sql, function (err, data, fields) {
  if (err) throw err;
  res.render('Signup', { title: 'Signup', Station: data});
});
});

 app.post('/Signup', function(req,res,next){
   var name = req.body.name;
   var Police_id = req.body.police_id;
   var DESIGNATION = req.body.DESIGNATION;
   var Pnumber = req.body.number;
   var pass = req.body.password;
   var Station_id = req.body.Station_id;
   var email = req.body.email;

   var sql = `INSERT INTO police VALUES ("${Police_id}", "${name}", "${DESIGNATION}", "${Pnumber}","${Station_id}","${pass}","${email}")`;
  con.query(sql, function(err, result) {
    if (err) throw err;
    console.log('record inserted');
    //req.flash('success', 'Data added successfully!');
    res.redirect('/');
  });
 })

//  app.get('/FIR', (req, res) => {
//   res.render('FIR',{ title: 'FIR' });
//  });

app.get('/FIR', function(req, res, next) {
  var sql='SELECT * FROM Crime';
  con.query(sql, function (err, data, fields) {
  if (err) throw err;
  res.render('FIR', { title: 'Crime', Cri: data});
});
});

 app.post('/FIR', function(req,res,next){
  var fir_no = req.body.fir_no;
  var date = req.body.date;
  var name = req.body.name;
  var place = req.body.place;
  var crime_id = req.body.crime_id;
  var Police_id = req.body.Police_id;
  
  //var email = req.body.email;

  var sql = `INSERT INTO FIR VALUES ("${fir_no}", "${date}", "${name}", "${place}","${crime_id}")`;
 con.query(sql, function(err, result) {
   if (err) throw err;
   console.log('record inserted');
   //req.flash('success', 'Data added successfully!');
   res.redirect('/AddCriminal');
 });
})

 app.get('/AddCriminal', (req, res) => {
  res.render('AddCriminal',{ title: 'AddCriminal' });
 });

 app.post('/AddCriminal', function(req,res,next){
  var name = req.body.name;
  var Criminal_id = req.body.Criminal_id;
  var Address = req.body.Address;
  var Crime_id = req.body.Crime_id;
  var Fir_no = req.body.Fir_no;
  var Police_id = req.body.Police_id;
  
  //var email = req.body.email;

  var sql = `INSERT INTO criminal VALUES ("${name}", "${Criminal_id}", "${Address}", "${Crime_id}","${Fir_no}","${Police_id}")`;
 con.query(sql, function(err, result) {
   if (err) throw err;
   console.log('record inserted');
   //req.flash('success', 'Data added successfully!');
   res.redirect('/Criminal');
 });
})

app.post('/Contact', function(req,res,next){
  var name = req.body.name;
  var email = req.body.email;
  var message = req.body.message;

  var sql = `INSERT INTO CONTACT VALUES ("${name}", "${email}", "${message}")`;
 con.query(sql, function(err, result) {
   if (err) throw err;
   console.log('record inserted');
   //req.flash('success', 'Data added successfully!');
   res.redirect('/Main');
 });
})



//Get method for associated and criminal

 app.get('/Associates', function(req, res, next) {
  var sql='SELECT * FROM police';
  con.query(sql, function (err, data, fields) {
  if (err) throw err;
  res.render('Associates', { title: 'Associates', Associates: data});
});
});

app.get('/Criminal', function(req, res, next) {
  var sql='SELECT * FROM Criminal';
  con.query(sql, function (err, data, fields) {
  if (err) throw err;
  res.render('Criminal', { title: 'Criminal', Criminal: data});
});
});

app.get('/Main', (req, res,next) => {
  var sql= 'SELECT * FROM CRIME';
  con.query(sql,function(err,data,fields){
    if(err)throw err;
   // console.log(data[1].COUNT)
  res.render('Main',{title: 'crime',data: data});
 });
})




// DELETING THE DATA

app.get('/Associates/delete/:id', function(req, res, next) {
   var id= req.params.id;
    var sql = 'DELETE FROM POLICE WHERE POLICE_id = ?';
    con.query(sql, [id], function (err, data) {
    if (err) throw err;
    console.log(data.affectedRows + " record(s) updated");
  });
  res.redirect('/Associates');
  
});

app.get('/Criminal/delete/:id', function(req, res, next) {
  var id= req.params.id;
   var sql = 'DELETE FROM Criminal WHERE Criminal_id = ?';
   con.query(sql, [id], function (err, data) {
   if (err) throw err;
   console.log(data.affectedRows + " record(s) updated");
 });
 res.redirect('/Criminal');
 
});

// UPDATING THE DATA



// Rendering other pages


 app.get('/about', (req, res) => {
  res.render('about');
 });

 app.get('/Contact', (req, res) => {
  res.render('Contact');
 });

 

 



app.listen(3000, () => {
  console.log("Server is running on port 3000");
})

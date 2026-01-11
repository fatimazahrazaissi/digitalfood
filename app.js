const express = require('express');
const mysql = require('mysql2');
const app = express();

app.set('view engine', 'ejs');
app.use(express.static('public')); 
app.use(express.urlencoded({ extended: true })); 

// Connexion MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '20052005', 
    database: 'food_db'
});

db.connect((err) => {
    if (err) throw err;
    console.log("Connecté à Database !");
});

// ROUTE 1 : Page de présentation 
app.get('/', (req, res) => {
    res.render('home'); 
});

// ROUTE 2 : Affichage du Menu 
app.get('/menu', (req, res) => {
    db.query("SELECT * FROM dishes", (err, results) => {
        if (err) throw err;
        res.render('menu', { allDishes: results });
    });
});

// ROUTE 3 : Page Formulaire
app.get('/checkout', (req, res) => {
    res.render('checkout');
});

// ROUTE 4 : Traitement de la commande
app.post('/confirm-order', (req, res) => {
    const { nom, prenom, tel, adresse, total_amount, cart_data } = req.body;
    const cart = JSON.parse(cart_data); 
    const date_commande = new Date().toISOString().slice(0, 19).replace('T', ' ');

    const sqlCmd = "INSERT INTO COMMANDE (nom_client, prenom_client, tel, date, adresse, montant_total) VALUES (?, ?, ?, ?, ?, ?)";
    db.query(sqlCmd, [nom, prenom, tel, date_commande, adresse, total_amount], (err, result) => {
        if (err) throw err;
        
        const id_commande = result.insertId;
        const items = Object.keys(cart).map(id_plat => [id_commande, id_plat, cart[id_plat].qty]);

        const sqlContenir = "INSERT INTO ContenirDans (id_commande, id_plat, quantité) VALUES ?";
        db.query(sqlContenir, [items], (err) => {
            if (err) throw err;
            res.send("<h1>Commande validée avec succès !</h1><a href='/'>Retour au menu</a>");
        });
    });
});

app.listen(3000, () => console.log("Lien : http://localhost:3000"));
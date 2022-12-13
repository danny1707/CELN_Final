import mysql from 'mysql'
import { promisify } from 'util'

const connection = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'restaurante'
})

connection.getConnection(
    (err, conn) => {
        if(err) {console.log('DB no conectada')}
        if(conn) {console.log('DB conectada')}
        return;
    }
)

connection.query = promisify(connection.query)

module.exports = connection;
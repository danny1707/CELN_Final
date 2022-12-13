import express from 'express'
const router = express.Router()

import connection from '../connection'

router.get('/obtener-meseros', async (req, res) => {
    try{
        const query = 'SELECT * FROM meseros'
        const meseros = await connection.query(query)
        res.json(meseros)
    } catch(error){
        return res.json({
            error
        })
    }
})

router.post('/eliminar-mesero', async(req, res) =>{
    try {
        const body = req.body
        const query = `DELETE FROM meseros WHERE mesero_id = ${body.mesero_id}`
        await connection.query(query)
        res.json('ok')
    } catch (error) {
        return res.json({
            error
        })
    }
})

router.post('/nuevo-mesero', async(req,res) =>{
    try {
        const body = req.body
        const query = `
            INSERT INTO meseros
            (mesero_nombre, mesero_ap_pat, mesero_ap_mat, mesero_salario, mesero_ini_turno, mesero_fin_turno)
            VALUES
            ('${body.mesero_nombre}', '${body.mesero_ap_pat}', '${body.mesero_ap_mat}', '${body.mesero_salario}', '${body.mesero_ini_turno}', '${body.mesero_fin_turno}')
        `
        await connection.query(query)
        res.json('ok')
    } catch (error) {
        return res.json({
            error
        })
    }
})


module.exports = router;
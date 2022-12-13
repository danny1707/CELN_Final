import express from 'express'
const router = express.Router()

import connection from '../connection'

router.get('/obtener-mesas', async (req, res) => {
    try{
        const query = 'SELECT * FROM mesas'
        const mesas = await connection.query(query)
        res.json(mesas)
    } catch(error){
        return res.json({
            error
        })
    }
})

router.post('/eliminar-mesa', async(req, res) =>{
    try {
        const body = req.body
        const query = `DELETE FROM mesas WHERE mesa_id = ${body.mesa_id}`
        await connection.query(query)
        res.json('ok')
    } catch (error) {
        return res.json({
            error
        })
    }
})

router.post('/nueva-mesa', async(req,res) =>{
    try {
        const body = req.body
        const query = `
            INSERT INTO mesas
            (mesa_capacidad)
            VALUES
            ('${body.mesa_capacidad}')
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
import express from 'express'
const router = express.Router()

import connection from '../connection'

router.get('/obtener-alimentos', async (req, res) => {
    try{
        const query = 'SELECT * FROM alimentos'
        const alimentos = await connection.query(query)
        res.json(alimentos)
    } catch(error){
        return res.json({
            error
        })
    }
})

router.post('/eliminar-alimento', async(req, res) =>{
    try {
        const body = req.body
        const query = `DELETE FROM alimentos WHERE ali_id = ${body.ali_id}`
        await connection.query(query)
        res.json('ok')
    } catch (error) {
        return res.json({
            error
        })
    }
})

router.post('/nuevo-alimento', async(req,res) =>{
    try {
        const body = req.body
        const query = `
            INSERT INTO alimentos
            (ali_nombre, ali_precio, ali_categoria)
            VALUES
            ('${body.ali_nombre}', ${body.ali_precio}, '${body.ali_categoria}')
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
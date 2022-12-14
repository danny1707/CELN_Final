import express from 'express'
const router = express.Router()

import connection from '../connection'

router.get('/obtener-ordenes', async (req, res) => {
    try{
        const query = `SELECT
                       O.ord_id, O.ord_mesa_id, M.mesero_id, M.mesero_nombre, M.mesero_ap_pat, O.ord_status, O.ord_fecha
                       FROM orden O, meseros M
                       WHERE O.ord_mesero_id = M.mesero_id`
        const ordenes = await connection.query(query)
        res.json(ordenes)
    } catch(error){
        return res.json({
            error
        })
    }
})

router.get('/obtener-ordenes', async (req, res) => {
    try{
        const body = req.body
        const query = `SELECT
                       O.ord_id, O.ord_mesa_id, M.mesero_id, M.mesero_nombre, M.mesero_ap_pat, O.ord_status, O.ord_fecha
                       FROM orden O, meseros M
                       WHERE O.ord_mesero_id = M.mesero_id AND O.ord_mesero_id = ${body.ord_mesero_id}`
        const ordenes = await connection.query(query)
        res.json(ordenes)
    } catch(error){
        return res.json({
            error
        })
    }
})

router.post('/nueva-orden', async(req, res) => {
    try {
        const body = req.body
        const query = `
            INSERT INTO orden
            (ord_mesa_id, ord_mesero_id, ord_status, ord_fecha)
            VALUES
            ('${body.ord_mesa_id}', '${body.ord_mesero_id}', 'Abierta', '${body.ord_fecha}')`
        await connection.query(query)
        res.json('ok')
    } catch (error) {
        return res.json({
            error
        })
    }
})

router.post('/status-orden', async(req, res) => {
    try {
        const body = req.body
        const query = `
            UPDATE orden
            SET ord_status = 'Pagada'
            WHERE ord_id = ${body.ord_id}`
        await connection.query(query)
        res.json('ok')
    } catch (error) {
        return res.json({
            error
        })
    }
})

router.post('/nuevo-det-orden', async (req, res) => {
    try {
        const body = req.body
        const query = `
            INSERT INTO detalles_orden
            (det_ord_id, det_ali_id)
            VALUES
            (${body.det_ord_id}, ${body.det_ali_id})
        `
        await connection.query(query)
        res.json('ok')
    } catch (error) {
        return res.json({
            error
        })
    }
})

router.get('/obtener-det-orden/:ord_id', async(req, res) => {
    try {
        const ord_id = req.params.ord_id
        const query = `
            SELECT
                A.ali_nombre
            FROM
                detalles_orden D, alimentos A
            WHERE
                D.det_ali_id = A.ali_id and D.det_ord_id = ${ord_id}
        `
        const ordenes = await connection.query(query)
        res.json(ordenes)
    } catch (error) {
        return res.json({
            error
        })
    }
})

module.exports = router;
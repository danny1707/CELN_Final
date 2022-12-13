import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue')
  },
  {
    path: '/alimentos',
    name: 'Alimentos',
    component: () => import('../views/Alimentos.vue')
  },
  {
    path: '/meseros',
    name: 'Meseros',
    component: () => import('../views/Meseros.vue')
  },
  {
    path: '/mesas',
    name: 'Mesas',
    component: () => import('../views/Mesas.vue')
  },
  {
    path: '/ordenes',
    name: 'Ordenes',
    component: () => import('../views/Ordenes.vue')
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router

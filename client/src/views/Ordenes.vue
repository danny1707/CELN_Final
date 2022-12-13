<template>
<div :style="{'background-image':'url(https://lh3.googleusercontent.com/ozeJ4qfvVV8XyFoIKWDdqcEV6CvqbeH4cjhwghFJi3ZIr7VsidYBSyNaU1-9dA8zsir091notNV3dVPEMXAJG9jgxaOpWQSK-eAntNwKRupzcXHlV5PXh2PFPsQZEmt1fMngib7OoRJeuuWtnUn-68fHjVrjsKLmYskr10qQGeQrQgJP9V0HT5jBbEBvOXwVvrrq__-fh_SZFth-0t4uH1qCvcOjNcDjknL0tcBUPYZjTTxqe66OfDUsu30lqt6vuRjwc550YH82aE8uD0EA9w5a11kyGDnVoA-91AqhnQOg4aKjYQ0EXbwBoq3yXhLx0r6Chmak9nqWOHh4LQskmDQMJGj-bn1OwI2BpdPTREopBYvPhy4XGezmojGOwE5Pcme19HoTDLao5VNBPkBWHtEIEwgu3e1Xq5XMOrRCV87iaja69O9TzyLdPVUAmXrKS5UOmhVzKW2MrjyCNprWud2jIZ1dqIvryCA07ifdyI5Va_a-Zo7Dt7td53k9X9Y63wDPGEoPsWDVEBJ_0cDdHQtqdbY25lliE8NoVcjlGcsIdpW7nIcRUYAyjMYilO45E0EsRLgmnsXPsuI32wSj2sE7j1nJ1BVZpiWM-hYNERH6GAjm8blkxTo75BL7vmpMWn75zEwcDl2u_YsUHYaiqucCHwACHTUll8KxyO-N6EYbasFJ8i-4QdUj9tiihw=w1691-h951-no?authuser=0)'}">
    <v-container>
        <v-data-table
        :headers="headers"
        :items="ordenes"
        :items-per-page="10"
        :search="search"
        class="elevation-1"
        >

        <template v-slot:top>
            <v-toolbar-title>
            Ordenes
            <v-spacer></v-spacer>
            <v-text-field
              v-model="search"
              append-icon="fas fa-search"
              label="Buscar en la tabla"
              single-line
              hide-details
            ></v-text-field>
        </v-toolbar-title>
                <v-spacer></v-spacer>
            <v-toolbar flat color="transparent">
            <v-spacer></v-spacer>
            <v-btn color="#f3c88c" class="mr-5" @click="na_dialog = true">Nueva Orden</v-btn>
            <v-btn color="#f3c88c" @click="v_dialog = true">Buscar Ventas</v-btn>
            </v-toolbar>
        <v-tabs
          v-model="tab"
          align-with-title
        >
          <v-tabs-slider color="yellow"></v-tabs-slider>

          <v-tab
            v-for="item in items"
            :key="item"
          > 

          </v-tab>
        </v-tabs>
        </template>

      <template v-slot:extension>
      </template>

        <template v-slot:item.edit="{item}">
            <v-icon @click="detalle_orden(item)" class="mr-3" small>
                fas fa-eye
            </v-icon>
            <v-icon v-show="item.ord_status!='Pagada'" @click="agregar_alimento(item)" small>
                fas fa-pencil-alt
            </v-icon>
        </template>
        <template v-slot:item.pay="{item}">
            <v-icon v-show="item.ord_status!='Pagada'" @click="agregar_pago(item)" small>
                fas fa-money-check-alt
            </v-icon>
        </template>
        </v-data-table>
        <v-dialog v-model="na_dialog" max-width="500px">
            <v-card>
                <v-card-title>Nueva Orden</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-select
                                :items="meseros"
                                v-model="nueva_orden.ord_mesero_id"
                                label="Mesero"
                                ></v-select>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="3">
                                <v-text-field
                                :items="mesas"
                                v-model="nueva_orden.ord_mesa_id"
                                label="Mesa"
                                type="number"
                                ></v-text-field>
                            </v-col>
                            <v-col cols="9">
                                <v-menu
                                v-model="menu1"
                                :close-on-content-click="false"
                                :nudge-right="40"
                                transition="scale-transition"
                                offset-y
                                min-width="290px"
                            >
                                <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                    v-model="nueva_orden.ord_fecha"
                                    label="Fecha de Orden"
                                    prepend-icon="far fa-calendar"
                                    readonly
                                    v-bind="attrs"
                                    v-on="on"
                                ></v-text-field>
                                </template>
                                <v-date-picker
                                v-model="nueva_orden.ord_fecha"
                                @input="menu1 = false"
                                ></v-date-picker>
                              </v-menu>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardar_orden()">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar()">Cancelar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <v-dialog v-model="no_dialog" max-width="500px">
            <v-card>
                <v-card-title>
                    Agregar Alimentos
                    <v-spacer></v-spacer>
                    <v-btn color="primary" @click="agregar_renglon()">Agregar Alimento</v-btn>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row v-for="(alimento, index) in det_alimentos" v-bind:key="index">
                            <v-col cols="12">
                                <v-select
                                :items="alimentos"
                                label="Platillo/Bebida"
                                v-model="alimento.det_ali_id"
                                >
                                </v-select>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardar_alimentos()">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar()">Cancelar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <v-dialog v-model="a_dialog" max-width="500px">
            <v-card>
                <v-card-title>
                    Alimentos Consumidos
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row v-for="(alimento, index) in alimentos_pedidos" v-bind:key="index">
                            <v-col cols="12">
                                <v-text-field
                                    label="Platillo/Bebida"
                                    v-model="alimento.ali_nombre"
                                    disabled
                                >
                                </v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn @click="a_dialog = false" color="primary">Cerrar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <v-dialog v-model="np_dialog" max-width="300px">
            <v-card>
                <v-card-title>
                    <v-spacer></v-spacer>
                    ¿Desea cerrar la orden?
                    <v-spacer></v-spacer>
                </v-card-title>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="pagar_orden()">Pagar</v-btn>
                    <v-btn color="error" @click="cancelar()">Cancelar</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-dialog>
        </v-dialog>
        <v-dialog v-model="v_dialog" max-width="300px">
            <v-card>
                <v-card-title>Venta Total Por Día</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-menu
                                v-model="menu2"
                                :close-on-content-click="false"
                                :nudge-right="40"
                                transition="scale-transition"
                                offset-y
                                min-width="290px"
                            >
                                <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                    v-model="bus_ventas.bus_fecha"
                                    label="Fecha de Orden"
                                    prepend-icon="far fa-calendar"
                                    readonly
                                    v-bind="attrs"
                                    v-on="on"
                                ></v-text-field>
                                </template>
                                <v-date-picker
                                v-model="bus_ventas.bus_fecha"
                                @input="menu2 = false"
                                ></v-date-picker>
                              </v-menu>
                            </v-col>
                        </v-row>
                        <v-row v-for="(prop, index) in this.bus_ventas.bus_total" :key="index">
                            <v-col cols="12">
                                <v-text-field
                                    label="Venta Total Del Día"
                                    v-model="prop.total"
                                    prefix="$"
                                    disabled
                                >
                                </v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="buscar_venta()">Buscar</v-btn>
                    <v-btn color="error" @click="cancelar()">Cerrar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-container>
</div>
</template>

<script>
export default {
    name: 'Ordenes',
    data () {
      return {
        search: '',
        headers: [
          { text: 'Identificador', align: 'start', sortable: true, value: 'ord_id'},
          { text: 'Mesa', sortable: true, value: 'ord_mesa_id'},
          { text: 'Nombre del Mesero', sortable: true, value: 'mesero_nombre'},
          { text: 'Apellido del Mesero', sortable: true, value: 'mesero_ap_pat'},
          { text: 'Total', sortable: true, value: 'ord_total'},
          { text: 'Estatus', sortable: true, value: 'ord_status'},
          { text: 'Fecha', sortable: true, value: 'ord_fecha'},
          { text: 'Ver/Editar', align: 'start', value: 'edit'},
          { text: 'Pagar', align: 'center', value: 'pay'}
         ],
         ordenes: [],
         meseros: [],
         mesas: [],
         alimentos: [],

         na_dialog: false,
         no_dialog: false,
         np_dialog: false,
         a_dialog: false,
         v_dialog: false,
         menu1: false,

         nueva_orden:{
           ord_mesa_id: '',
           ord_mesero_id: '',
           ord_status: '',
           ord_fecha: ''
         },
         
         bus_ventas:{
             bus_fecha: '',
             bus_total: ''
         },

         det_alimentos: [],
         det_ord_id: '',
         ord_id: '',
         alimentos_pedidos: []
        }
      },
      created(){
        this.llenar_ordenes()
        this.llenar_meseros()
        this.llenar_alimentos()
        this.llenar_mesas()
      },

      methods: {
        async llenar_ordenes(){
          const api_data = await this.axios.get('/ordenes/obtener-ordenes')
          this.ordenes = api_data.data
        },

        async llenar_meseros(){
         const api_data = await this.axios.get('/meseros/obtener-meseros')
         api_data.data.forEach((item) => {
             this.meseros.push({
                 text: item.mesero_nombre + ' ' + item.mesero_ap_pat + ' ' + item.mesero_ap_mat,
                 value: item.mesero_id
             })
         });
        },

        async llenar_mesas(){
         const api_data = await this.axios.get('/mesas/obtener-mesas')
         this.mesas = api_data.data
        },

        async llenar_alimentos(){
         const api_data = await this.axios.get('/alimentos/obtener-alimentos')
         api_data.data.forEach((item) => {
             this.alimentos.push({
                 text: item.ali_nombre,
                 value: item.ali_id
             })
         });
        },
        cancelar(){
          this.nueva_orden = {}
          this.det_alimentos = []
          this.na_dialog = false
          this.no_dialog = false
          this.np_dialog = false
          this.v_dialog = false
        },
        
        async buscar_venta(){
            const api_data = await this.axios.get('/ordenes/buscar-venta/' + this.bus_ventas.bus_fecha)
            this.bus_ventas.bus_total = api_data.data
        },

        async guardar_orden(){
          await this.axios.post('/ordenes/nueva-orden', this.nueva_orden)
          this.llenar_ordenes()
          this.cancelar()
        },

        async pagar_orden(){
            const body = 
            {
                pay_ord_id: this.pay_ord_id,
            }
            console.log(body)
            await this.axios.post('/ordenes/status-update', body)
            this.llenar_ordenes()
            this.cancelar()
        },

        async agregar_pago(item){
            this.pay_ord_id = item.ord_id
            this.np_dialog = true
        },

        async total_update(body){
            await this.axios.post('/ordenes/actualizar-total', body)
        },

        async guardar_alimentos(){
            const body = {
                det_ord_id: this.det_ord_id,
                det_ali_id: ''
            }
            this.det_alimentos.forEach( async (alimento) => {
                body.det_ali_id = alimento.det_ali_id
                await this.axios.post('/ordenes/nuevo-det-orden', body)
            })
            this.total_update(body)
            this.llenar_alimentos()
            this.cancelar()
        },

        async agregar_alimento(item){
            this.det_ord_id = item.ord_id
            this.no_dialog = true
        },

        agregar_renglon(){
            this.det_alimentos.push({
                det_ali_id: ''
            })
        },

        async detalle_orden(item){
            const api_data = await this.axios.get('/ordenes/obtener-det-orden/' + item.ord_id.toString())
            this.alimentos_pedidos = api_data.data
            this.a_dialog = true
        }
      },
}
</script>
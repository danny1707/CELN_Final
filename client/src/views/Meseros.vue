<template>
<div :style="{'background-image':'url(https://lh3.googleusercontent.com/jkuNSgJIUyIA5c7P8fyH-N_-XChvGaa-Z1IvBHd4E5B697ty9KljMpTJQWTz10nVt9C3K96crsJHJqwEAH1o24qgqZ8-ZWNdMab9ExaXY28SYgYUCaWt9rCIjjR72GqzyvMhsWwZuR4Ii2gNE5MBo1rLVfR6edzHDTKiLhBvt_4Srx9O9gL4JD0WD1FAamBiCxerY5QTmUsRLexJTeqRtRr7NOoBGeolgvNEY_Ba4T9vzcGxmktdzDW-pR-ZMS2te07WZywfzJwQ-47zeltNCqWYVyoCN9YHYPK_wrmPIfYRuN0N7lMnBaODeMma7uAQ6jNgNWSOBlCB0V5JnFPmyBNavTtGOIrKS2bKRZWKA7_JwE02qimijdCPsNQdtvAOuUAGB22fG3MvdobiIfadufRQ7ogheRnwixXb9VvONMYPKKjb65xFm7msMB9FfBagIZpNIxjs-l1P3AZCWDl4nkxKzo0onr1seIS2zQw91gNDsykujR1GCQck2O-6wD7HluovtlR-JSpg1ZvVUcbtFw_wfIkOutlw8_V8rwCOeIyDxzMiP_jID36iohu9TAXdevGCBOSV6Ac0V4PdFiFKhEq-kAH8ar4K_wH0SKqyaQPKvYaG7zl67V7-yZFEdWTKtxxfen2WfouL-g-LAYGNKpqecjEWvboAvRkzMEPF2pUGcVuub2d0stpQDKzJ9w=w1691-h951-no?authuser=0)'}">
    <v-container><v-card>
    <v-toolbar
      color="#a07540"
      dark
      flat
    >
    <v-toolbar-title>
              Meseros
            <v-spacer></v-spacer>
            <v-text-field
              v-model="search"
              append-icon="fas fa-search"
              label="Buscar en la tabla"
              single-line
              hide-details
            ></v-text-field>
            </v-toolbar-title>
        <v-toolbar flat color="transparent">
        <v-spacer></v-spacer>
            <v-btn color="#f3c88c" @click="nl_dialog = true">Nuevo Mesero</v-btn>
      </v-toolbar>

      <template v-slot:extension>
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
    </v-toolbar>

    <v-tabs-items v-model="tab">
      <v-tab-item
        v-for="item in items"
        :key="item"
      >
      <v-main>
        <router-view></router-view>
      </v-main>
      </v-tab-item>
    </v-tabs-items>
  </v-card>
        <v-data-table
        :headers="headers"
        :items="meseros"
        :items-per-page="5"
        :search="search"
        >

        <template v-slot:item.actions="{item}">
        <v-icon @click="eliminar_mesero(item)" small>
            fas fa-trash
        </v-icon>
        </template>

        </v-data-table>
        <v-dialog v-model="nl_dialog" max-width="900px">
            <v-card>
                <v-card-title>
                Nuevo Mesero
                </v-card-title>
                <v-card-text>
                <v-container>
                    <v-row>
                    <v-col cols="6">
                        <v-text-field
                        v-model="nuevo_mesero.mesero_nombre"
                        label="Nombre"
                        ></v-text-field>
                    </v-col>
                    <v-col cols="6">
                        <v-text-field
                        v-model="nuevo_mesero.mesero_ap_pat"
                        label="Apellido Paterno">
                        </v-text-field>
                    </v-col>
                    </v-row>
                    <v-row>
                    <v-col cols="6">
                        <v-text-field
                        v-model="nuevo_mesero.mesero_ap_mat"
                        label="Apellido Materno">
                        </v-text-field>
                    </v-col>
                    <v-col cols="6">
                        <v-text-field
                        v-model="nuevo_mesero.mesero_salario"
                        label="Salario"
                        prefix="$">
                        </v-text-field>
                    </v-col>
                    </v-row>
                    <v-row>
                    <!--<v-col cols="6">
                        <v-text-field
                        v-model="nuevo_mesero.mesero_ini_turno"
                        label="Hora de Inicio de Turno">
                        </v-text-field>
                    </v-col>
                    <v-col cols="6">
                        <v-text-field
                        v-model="nuevo_mesero.mesero_fin_turno"
                        label="Hora de Fin de Turno">
                        </v-text-field>
                    </v-col>-->
                    <div>
                      <h1>Ingreso/Salida:</h1>
                      <v-row
                        justify="space-around"
                        align="center"
                      >
                        <v-col style="width: 400px; flex: 0 1 auto;" align="right">
                          <h2>Entrada:</h2>
                          <v-time-picker
                            v-model="nuevo_mesero.mesero_ini_turno"
                            :max="nuevo_mesero.mesero_fin_turno"
                          ></v-time-picker>
                        </v-col>
                        <v-col style="width: 400px; flex: 0 1 auto;" align="left">
                          <h2>Salida:</h2>
                          <v-time-picker
                            v-model="nuevo_mesero.mesero_fin_turno"
                            :min="nuevo_mesero.mesero_ini_turno"
                          ></v-time-picker>
                        </v-col>
                      </v-row>
                    </div>
                    </v-row>
                </v-container>
                </v-card-text>
                <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="success" @click="guardar()">Guardar</v-btn>
                <v-btn color="error" @click="cancelar()">Cancelar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-container>
</div>
</template>

<script>
export default {
    name: 'Meseros',
    data () {
      return {
        search: '',
        items: [
          'Home', 'Alimentos', 'Meseros', 'Mesas', 'Ordenes'],
        headers: [
          { text: 'Identificador', align: 'start', sortable: true, value: 'mesero_id',},
          { text: 'Nombre(s)', sortable: true, value: 'mesero_nombre',},
          { text: 'Apellido Paterno', sortable: true, value: 'mesero_ap_pat',},
          { text: 'Apellido Materno', sortable: true, value: 'mesero_ap_mat',},
          { text: 'Salario', sortable: true, value: 'mesero_salario',},
          { text: 'Inicio de Turno', sortable: true, value: 'mesero_ini_turno',},
          { text: 'Final de Turno', sortable: true, value: 'mesero_fin_turno',},
          { text: 'Acciones', align: 'center', value: 'actions',},
         ],
         meseros: [],

         nl_dialog: false,

         nuevo_mesero:{
           mesero_nombre: '',
           mesero_ap_pat: '',
           mesero_ap_mat: '',
           mesero_salario: '',
           //mesero_ini_turno: '',
           //mesero_fin_turno: ''
           mesero_ini_turno: null,
           mesero_fin_turno: null
         }
        }
      },
      created(){
        this.llenar_meseros()
      },

      methods: {
        async llenar_meseros(){
         const api_data = await this.axios.get('/meseros/obtener-meseros')
         this.meseros = api_data.data
        },

        async eliminar_mesero(item){
          const body = {
            mesero_id: item.mesero_id
          }
          await this.axios.post('/meseros/eliminar-mesero', body)

          this.llenar_meseros()
        },

        cancelar(){
          this.nuevo_mesero = {}
          this.nl_dialog = false
        },

        async guardar(){
          await this.axios.post('/meseros/nuevo-mesero', this.nuevo_mesero)
          this.llenar_meseros()
          this.cancelar()
        }
          
      },
}
</script>
<template>
    <div align="center" :style="{'background-image':'url(https://lh3.googleusercontent.com/8WcC8emIpXP8JmJKXle_ge8MQVm0dzU6YZuHEKAZJI5YobDjd88D2Uz0oMAas9HuHbqumLENPzGhxOz88979RL-Pv5APcp26_Xwy1yyYa_w3EiaJF3BeQDmyvXZL1MkXk-CeQM3lVkDOBEzkN9DFMKIOYN5uN8TbVQ9Q5jKB9N8tlyNotFrR8eW8CxzXdezLFbVNwhMYv31BFapNJs6HVAoFNJ6EOvG9PGTCG5I5BU6viZpWA6__jRz1NreNliaAMUp3bamS9VBhAMPCkk5zZ989O0ccoqdJHG3OetGH3SGzTJtPAbwKGlprGmfvT3N8mBEE8U-2-m0LoCHL3Cf8m0bDIeXwSce6PPM_-ylq6OdRGwXxic0e0Y0ZnWM3sa7bmxucvLQznwCGT2YCm1Y6-5ass2Wxkv_psgKvQo9TzlW_liOkv-RwiLbM4AKOGICUACeBOI1uXE0ZsZ0_5yiFs2jtJp6aAJmDlOE-TxZ1r-PRw-UL_w4K0EuQDqnVbBJWbms82C0sln4WD0jmbPQ4o_40Y8P1F7-6UHWWRn_8362FGYkbSb1JZsSwHYM30DroE2Dqo2TAC-w1Rcm7Tb8qOaCckPADH1eA_rHuk2qhRhRAeJTeP_Tua2vENkcoGCzB1gLZI3XKX-_OagfT2uGXbkK1NlVQy0FvLc6V6tOvdbrdU5HyvWS_ILrXPJ9wmA=w1690-h950-no?authuser=0)'}">
    <v-container style="width: 700px">
    <v-card>
    <v-toolbar
      color="#a07540"
      dark
      flat
      style="width: 700px"
    >
    
            <v-toolbar-title align="left">
              Mesas
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
            <v-btn color="#f3c88c" @click="nl_dialog = true">Nueva Mesa</v-btn>
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
        :items="mesas"
        :items-per-page="5"
        :search="search"
        style="width: 700px"
        align="left"
        >
        <template v-slot:item.actions="{item}">
        <v-icon @click="eliminar_mesa(item)" small>
            fas fa-trash
        </v-icon>
        </template>

        </v-data-table>
        <v-dialog v-model="nl_dialog" max-width="250px">
            <v-card>
                <v-card-title>
                Nueva Mesa
                </v-card-title>
                <v-card-text>
                <v-container>
                    <v-row>
                    <v-col cols="12">
                        <v-text-field
                        v-model="nueva_mesa.mesa_capacidad"
                        label="Capacidad"
                        type="number"
                        ></v-text-field>
                    </v-col>
                    <!-- <v-col cols="6">
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
                        label="Salario">
                        </v-text-field>
                    </v-col>
                    </v-row>
                    <v-row>
                    <v-col cols="6">
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
                    </v-col> -->
                    </v-row>
                </v-container>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn color="success" @click="guardar()">Guardar</v-btn>
                  <v-btn color="error" @click="cancelar()">Cancelar</v-btn>
                  <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-container>
    </div>
</template>

<script>
export default {
    name: 'Mesas',
    data () {
      return {
        search: '',
        items: [
          'Home', 'Alimentos', 'Meseros', 'Mesas', 'Ordenes'],
        headers: [
          { text: 'Identificador', align: 'start', sortable: true, value: 'mesa_id',},
          { text: 'Capacidad', sortable: true, value: 'mesa_capacidad',},
          { text: 'Acciones', align: 'center', value: 'actions',},
         ],
         mesas: [],

         nl_dialog: false,

         nueva_mesa:{
           mesa_capacidad: ''
         }
        }
      },
      created(){
        this.llenar_mesas()
      },

      methods: {
        async llenar_mesas(){
         const api_data = await this.axios.get('/mesas/obtener-mesas')
         this.mesas = api_data.data
        },

        async eliminar_mesa(item){
          const body = {
            mesa_id: item.mesa_id
          }
          await this.axios.post('/mesas/eliminar-mesa', body)

          this.llenar_mesas()
        },

        cancelar(){
          this.nueva_mesa = {}
          this.nl_dialog = false
        },

        async guardar(){
          await this.axios.post('/mesas/nueva-mesa', this.nueva_mesa)
          this.llenar_mesas()
          this.cancelar()
        }
          
      },
}
</script>
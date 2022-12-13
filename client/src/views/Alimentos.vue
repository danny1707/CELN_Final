<template>
<div :style="{'background-image':'url(https://lh3.googleusercontent.com/1eU7M9TIyAzJsKXi4YFHFrRysIQJhCrU2u_tuGvUy4ggiXi0qtH-zxR5WuAYZWPuHL5jDEMzcRxirfIlqUS5GkkyCUnD3aMEaXaSqXtzkf9THU0jjCwVQETJ2BEpkGg0cCByq125vIfx3vHNN0m_H2JKUqEHW34kXGNyIz-tRwvXRUA3jG5SYgVNpJQ8PjkS6g2nc3rvbUUVXMUNATSsya_xdF8rcWquAUAZorEl1IknjwFUB4JlDYiZ1Z8GhcpyDQxmasB9J3cDdHS9d_E-CbnQxv9gN0rxpgvFtR8JgfXfz9NMNzJnu8aqdEEZoX9oPpTe-g_6lGbyyDSLAT0n-buRMnFHubJm-IRlcr_EvzWfaNohX6IkU1l3YKov1E8gTctPUpAXihNMxZo8Ov61TCZNpVm4vTPeTSem1v42PI7wE4tBwWpBaDWNu_BSPuN8ip-4eIBJdX8VJSleRsnjn5y2YaOUA8MXlwyG33r_Oh7R2Akwp2GUen6RDdPYylHUdr1txGTVBfKPYJTB3ubCGXdHNy4ABDy3RHAuBz9paWpybMgeKPE039lVvom2ehJ3wThMttNyhXI0_pu8Ubb7PWQ_SxehT8TU3dU8ARi5VGw8DhVp3xP9RD4Felg6RqAsk0ZHjWbZAAwukV9CrxzeucrWudyvhJTsvyPaMqf1AnXJLFAH_9ldAcYBwrlpJw=w1691-h951-no?authuser=0)'}">
  <v-container >
  <v-card>
    <v-toolbar
      color="#a07540"
      dark
      flat
    >
    <v-toolbar-title>
          Alimentos
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
        <v-btn color="#f3c88c" @click="nl_dialog = true">Nuevo Alimento</v-btn>
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
  <div>
    <v-data-table
    :headers="headers"
    :items="alimentos"
    :items-per-page="5"
    :search="search"
    class="elevation-1"
    >
    <template v-slot:item.actions="{item}">
      <v-icon @click="eliminar_alimento(item)" small>
        fas fa-trash
      </v-icon>
    </template>
  </v-data-table>
  <v-dialog v-model="nl_dialog" max-width="500px">
    <v-card>
      <v-card-title>
        Nuevo Alimento
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="6">
              <v-text-field
                v-model="nuevo_alimento.ali_nombre"
                label="Nombre"
              ></v-text-field>
            </v-col>
            <v-col cols="6">
              <v-text-field
                v-model="nuevo_alimento.ali_precio"
                label="Precio"
                type="number">
              </v-text-field>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
              <!--<v-text-field
                v-model="nuevo_alimento.ali_categoria"
                label="Categoria">
              </v-text-field>-->
              <v-autocomplete
                ref="country"
                v-model="nuevo_alimento.ali_categoria"
                :rules="[() => !!Categoria || 'This field is required']"
                :items="Categorias"
                label="Categoría"
                placeholder="Select..."
                required
              ></v-autocomplete>
            </v-col>
            <!-- <v-col cols="6">
              <v-text-field
                v-model="nuevo_libro.lib_edicion"
                label="Edicion"
                type="number">
              </v-text-field>
            </v-col> -->
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
  </div>
  </v-container>
</div>
</template>

<script>
  export default {
    name: 'Alimentos',
    data () {
      return {
        search: '',
        tab: null,
        items: [
          'Home', 'Alimentos', 'Meseros', 'Mesas', 'Ordenes'],
        Categorias: ['Antojitos', 'Postres', 'Cervezas', 'Ensaladas', 'Pescados', 'Carnes', 'Refrescos'],
        headers: [
          { text: 'Identificador', align: 'start', sortable: true, value: 'ali_id',},
          { text: 'Nombre', sortable: true, value: 'ali_nombre',},
          { text: 'Precio', sortable: true, value: 'ali_precio',},
          { text: 'Categoria', sortable: true, value: 'ali_categoria',},
          { text: 'Acciones', align: 'center', value: 'actions',},
         ],
         alimentos: [],

         list_cat: [
        { title: 'Postres', value: 'Postres'},
        { title: 'Bebidas', value: 'Bebidas'},
        { title: 'Ensaladas' },
        { title: 'Cervezas' },
        { title: 'Carnes' },
        { title: 'Pescados' },
        { title: 'Antojitos' },
      ],

         nl_dialog: false,
         nuevo_alimento:{
           ali_nombre: '',
           ali_precio: '',
           ali_categoria: ''
         }
        }
      },
      created(){
        this.llenar_alimentos()
      },

      methods: {
        async llenar_alimentos(){
          const api_data = await this.axios.get('/alimentos/obtener-alimentos')
          this.alimentos = api_data.data
        },

        async eliminar_alimento(item){
          const body = {
            ali_id: item.ali_id
          }
          await this.axios.post('/alimentos/eliminar-alimento', body)

          this.llenar_alimentos()
        },

        cancelar(){
          this.nuevo_alimento = {}
          this.nl_dialog = false
        },

        async guardar(){
          await this.axios.post('/alimentos/nuevo-alimento', this.nuevo_alimento)
          this.llenar_alimentos()
          this.cancelar()
        }
      },
    }
</script>
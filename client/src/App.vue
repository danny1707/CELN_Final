<template>
  <v-app>
    <v-app-bar
      app
      color="#f3c88c"
      dark
    >
      <div class="d-flex align-center">
        <router-link :to="{name: 'Home'}">
        <v-img
          alt="Vuetify Logo"
          class="shrink mr-2"
          contain
          src="https://lh3.googleusercontent.com/9p7GXIvo0wnzOYpfCVbMLozZGxMPfGKAzdNsRXcUEze3GUgIlDGq4dzTD93JP6pfeuGs9ekv5dEW8fD6zHvz1Slv6_vvv8OSNBAek2d4wM3j01K8f70GHeFL4f6nY3xjvrNsGNkYPHBALKvwTFJ6_YlI3HFLRp0fRwKYEJtcuia_EqlcezJZ_H2OX07SRRHn-ZubuAN5cgpIbqbGZXlsKLmIqD6_vsBRRj2nClBYKWsHi3ohKTb2rMeLfZGI3Hu8Mm9I8fvYejeuTbMyEYJh2Ly1hVGeK9td-ktgbUJaSrQN0OLw5JlaJ1cRLXCBXusjN6bx5yLQZ3aFVvqz1CVPl3YzC_JbhNW2XkU-kXnKTTQbPaklqiYnTI7OKizANY7cI8Er_oI2SLTEXS_JmK3JoPNFP3M0LJGUQCq9YaS4O1RaRxePiMD-uJCxEHovxqnjyBBkciVnceSewW-2SAxIvum9vXM903Ye2Cf2ruM-x4-KiJGdSzg55GwawwWo_1Z0HhpfcD0pJ8z3cVrFJrbDeIqTg9Ki5CdXUs6gD-w-jRRxhrEHl24VBAY5deWoMnlw73gf7T84dq6z_t2UecDKzL3w7GEpGTnP4eula-YsEiVEFTHr7Zypc7EU9y2mp99SqWN97jLl11UfqmM6oyBsaErW_91mE6dW3EJhLh685VqoeJQIK4L5762VbQK_sQ=s600-no?authuser=0"
          transition="scale-transition"
          width="60"
        >
        </v-img></router-link>

        <router-link :to="{name: 'Home'}">
        <v-img
          alt="Vuetify Name"
          class="shrink mt-1 hidden-sm-and-down"
          contain
          min-width="100"
          src="https://dewey.tailorbrands.com/production/brand_version_mockup_image/443/4310929443_f49a2dbd-7c09-4d40-9983-c215cb2bf512.png?cb=1608282236"
          width="150"
        /></router-link>
      </div>

        
        <!--<v-row class="my-5">
          <v-spacer></v-spacer>
          <router-link :to="{name: 'Home'}" class="ml-10">Home</router-link>
          <router-link :to="{name: 'Alimentos'}" class="ml-10">Alimentos</router-link>
          <router-link :to="{name: 'Meseros'}" class="ml-10">Meseros</router-link>
          <router-link :to="{name: 'Mesas'}" class="ml-10">Mesas</router-link>
          <router-link :to="{name: 'Ordenes'}" class="ml-10">Órdenes</router-link>
          <v-spacer></v-spacer>
        </v-row>-->

<!-- SEPARADOR -- SEPARADOR -- SEPARADOR -- SEPARADOR -- SEPARADOR -->
<!--<div class="text-center">-->
  <v-spacer></v-spacer>
    <div class="mr-15">
    <v-bottom-sheet v-model="sheet">
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          color="secondary"
          elevation="3"
          outlined
          raised
          rounded
          x-large
          v-bind="attrs"
          v-on="on"
        >
          Todos los apartados
        </v-btn>
      </template>
      <v-list>
        <v-subheader>Apartados</v-subheader>
        <v-list-item
          v-for="tile in tiles"
          :key="tile.title"
          @click="sheet = false"
        >
          <v-list-item-avatar>
            <v-avatar
              size="32px"
              tile
            >
            <v-icon @click="ico(item)" medium>
              {{tile.img}}
            </v-icon>
            </v-avatar>
          </v-list-item-avatar>
          <v-btn
          color="secondary"
          elevation="2"
          large
          outlined
          raised
          rounded
          text
          v-bind="attrs"
          v-on="on"
          >
          <li><router-link tag="li" :to="{name: tile.title}"><v-list-item-title>{{ tile.title }}</v-list-item-title></router-link></li>
          </v-btn>

        </v-list-item>
      </v-list>
    </v-bottom-sheet>
    </div>
<!-- SEPARADOR -- SEPARADOR -- SEPARADOR -- SEPARADOR -- SEPARADOR -->
  <v-spacer></v-spacer>
  <div class="ml-10">
    <v-bottom-sheet
      v-model="shet"
      inset
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          color="secondary"
          elevation="2"
          icon
          large
          outlined
          raised
          rounded
          v-bind="attrs"
          v-on="on"
        >
          <v-icon @click="info(item)" medium>
            fas fa-info
          </v-icon>
        </v-btn>
      </template>
      <v-sheet
        class="text-center"
        height="200px"
      >
        <v-btn
          class="mt-6"
          text
          color="error"
          @click="shet = !shet"
        >
          close
        </v-btn>
        <div class="my-3">
          Page designed by 
        </div>
        <div class="my-3">
          Daniel Nájera Flores; Victor Raymundo Gonzalez Vela;
        </div>
      </v-sheet>
    </v-bottom-sheet>
  </div>
    </v-app-bar>

    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>
</template>

<script>

export default {
  name: 'App',

  components: {
  },

  data: () => ({
    //
  }),
};
</script>

<script>
  export default {
    data: () => ({
      sheet: false,
      tiles: [
        { img: 'fas fa-utensils', title: 'Alimentos' },
        { img: 'fas fa-user-alt', title: 'Meseros' },
        { img: 'fas fa-map-marker-alt', title: 'Mesas' },
        { img: 'fas fa-file-alt', title: 'Ordenes' },
      ],
      jom: [
        { neim: 'Home' },
      ],
      shet: false,
    }),
  }
</script>
<template>
  <v-carousel height="696px">
    <li>
    <v-carousel-item
      v-for="tile in tiles"
      :key="tile.title"
      :src="tile.src"
      :to="{name: tile.title}"
      reverse-transition="fade-transition"
      transition="fade-transition"
    >
    <!--<router-link tag="li" :to="{name: tile.title}"><v-list-item-title>{{ tile.title }}</v-list-item-title></router-link>-->
    </v-carousel-item></li>
  </v-carousel>
</template>

<script>
  export default {
    data () {
      return {
        tiles: [
          {
            src: 'https://lh3.googleusercontent.com/2a-HuZzEcCrFSMlgSZM0GSklCJAQ-0q0xuff7BHVmYiP-oG9RH-c0lQZ8xc3jC6Fk_eXJAmhDMhcL6776C_4wdnWOq1ehsIRPIVJ1EMiQo4YDL4VJ8Aap8Q0LT9OrSdXwgna_WdjblbabUgbwoQdIrOTEcpgOv9CF4gQwuK9eNNbfbWIKtEzZZq7sg0hvSWVD_t8BJtC1DsVecBLohh7YEoE9C7ErbxRqaDXYMwdPunVH-fhOKKoi8h2O6kjN2z9nv_iy56Axd_WtORnc7jGY8vrP95G3nvO5hvXC7dyoB-k8aKCNEjQib13e-ZyTbN03Emiae7bcroO5UVGyD95-ZBKL5QHNtyhurfKgYZoK96vKPlQwn6FQ1H6WjWHFXPgocfJpRbd8faON_Rn-0DqQQ1m2l-pb8RJMsGh1JU9ACI1onxEEm8KSjauVtW_VJVfx122B3yYUo7RJs_9OomRNJWybxL1rAhgowpWgPgjk343f8r_Dq0xBfuzCkKK4HoTZ-v7_dzsaCUfczgGTQ6s8_paHfGGUE01DWjiiSWqz6BRJUVGe9_JBZIUMk0U19wM87zTOV6sJsL3v1LcMepYtEUaUkl-H92u9rdZIBDQFkpeUU8TVRQbmOfAw3MpxMyAXfg3ke5-UoUm8zqofv_3NtO0HnTY7nxIu2jqjg0-CO_AIszminlQJ6YzWFgHZg=w1280-h720-no?authuser=0',
            title: 'Home'
          },
          {
            src: 'https://lh3.googleusercontent.com/1eU7M9TIyAzJsKXi4YFHFrRysIQJhCrU2u_tuGvUy4ggiXi0qtH-zxR5WuAYZWPuHL5jDEMzcRxirfIlqUS5GkkyCUnD3aMEaXaSqXtzkf9THU0jjCwVQETJ2BEpkGg0cCByq125vIfx3vHNN0m_H2JKUqEHW34kXGNyIz-tRwvXRUA3jG5SYgVNpJQ8PjkS6g2nc3rvbUUVXMUNATSsya_xdF8rcWquAUAZorEl1IknjwFUB4JlDYiZ1Z8GhcpyDQxmasB9J3cDdHS9d_E-CbnQxv9gN0rxpgvFtR8JgfXfz9NMNzJnu8aqdEEZoX9oPpTe-g_6lGbyyDSLAT0n-buRMnFHubJm-IRlcr_EvzWfaNohX6IkU1l3YKov1E8gTctPUpAXihNMxZo8Ov61TCZNpVm4vTPeTSem1v42PI7wE4tBwWpBaDWNu_BSPuN8ip-4eIBJdX8VJSleRsnjn5y2YaOUA8MXlwyG33r_Oh7R2Akwp2GUen6RDdPYylHUdr1txGTVBfKPYJTB3ubCGXdHNy4ABDy3RHAuBz9paWpybMgeKPE039lVvom2ehJ3wThMttNyhXI0_pu8Ubb7PWQ_SxehT8TU3dU8ARi5VGw8DhVp3xP9RD4Felg6RqAsk0ZHjWbZAAwukV9CrxzeucrWudyvhJTsvyPaMqf1AnXJLFAH_9ldAcYBwrlpJw=w1691-h951-no?authuser=0',
            title: 'Alimentos'
          },
          {
            src: 'https://lh3.googleusercontent.com/0COSh7Hnt271cTdzMTwxSVerPPchexxslxj9xPnwoIjtTqa4bCvr_yTiS6mgqUFs8lI1sbw-huqTLSZvF9a5hSRbSJEJAxVlVpgt0EZpq7WghVilkW9UA3iOrHSxILvZ0cpRXzj2haDXizxRNB_r7qmRW-kDm_mmyVf08atduQS2wYb8ab3xdNtgkko2zTtLbNme6QkKaspqPcPtuXA40kUNSzoFi8u70iSRBrmrXP-jNfrNDfwckZBWgP8zxXtRDBa5lrKZMJEY_00j_fWvLdFJcfxuSWiFWzdYDVT0dSpxhqztrJz1dZnWCusDn7FhpbF12SqkFhNMRKfTnvM4Gy4DAWLgwTfSRCU8c8JwJUCVkiB01aEldmWwExewLDPoTCjlTymRyWi4U717oDNm8uE4JsU6B18T8wTisaua8q4KHEy0fgLmPOneXt6Veyf43ZDji80learv32Sm75DcsQM1uwJ8KGqnXwCfTqCwi26cV2nWPDbwbRUbszWJNPrNdYmAlkFThXUTxXELauIlo9hmzeZPBeTAwI3n5-C9pm0R61FdJPGe0lAg8Ogo7cCKv1sOBDkumEC3sOMHMm9UlKjcswKvmpU3K7ZV0UJYMc6VCQqBJyvZwvOStJ9_es3j1304AQEZSHRSzAq2B2ZIH_IAIf4Zt9Qh8gg1nvwV-cpuPE52g2ey2nlIosTmkQ=w1691-h951-no?authuser=0',
            title: 'Mesas'
          },
          {
            src: 'https://lh3.googleusercontent.com/jkuNSgJIUyIA5c7P8fyH-N_-XChvGaa-Z1IvBHd4E5B697ty9KljMpTJQWTz10nVt9C3K96crsJHJqwEAH1o24qgqZ8-ZWNdMab9ExaXY28SYgYUCaWt9rCIjjR72GqzyvMhsWwZuR4Ii2gNE5MBo1rLVfR6edzHDTKiLhBvt_4Srx9O9gL4JD0WD1FAamBiCxerY5QTmUsRLexJTeqRtRr7NOoBGeolgvNEY_Ba4T9vzcGxmktdzDW-pR-ZMS2te07WZywfzJwQ-47zeltNCqWYVyoCN9YHYPK_wrmPIfYRuN0N7lMnBaODeMma7uAQ6jNgNWSOBlCB0V5JnFPmyBNavTtGOIrKS2bKRZWKA7_JwE02qimijdCPsNQdtvAOuUAGB22fG3MvdobiIfadufRQ7ogheRnwixXb9VvONMYPKKjb65xFm7msMB9FfBagIZpNIxjs-l1P3AZCWDl4nkxKzo0onr1seIS2zQw91gNDsykujR1GCQck2O-6wD7HluovtlR-JSpg1ZvVUcbtFw_wfIkOutlw8_V8rwCOeIyDxzMiP_jID36iohu9TAXdevGCBOSV6Ac0V4PdFiFKhEq-kAH8ar4K_wH0SKqyaQPKvYaG7zl67V7-yZFEdWTKtxxfen2WfouL-g-LAYGNKpqecjEWvboAvRkzMEPF2pUGcVuub2d0stpQDKzJ9w=w1691-h951-no?authuser=0',
            title: 'Meseros'
          },
          {
            src: 'https://lh3.googleusercontent.com/ozeJ4qfvVV8XyFoIKWDdqcEV6CvqbeH4cjhwghFJi3ZIr7VsidYBSyNaU1-9dA8zsir091notNV3dVPEMXAJG9jgxaOpWQSK-eAntNwKRupzcXHlV5PXh2PFPsQZEmt1fMngib7OoRJeuuWtnUn-68fHjVrjsKLmYskr10qQGeQrQgJP9V0HT5jBbEBvOXwVvrrq__-fh_SZFth-0t4uH1qCvcOjNcDjknL0tcBUPYZjTTxqe66OfDUsu30lqt6vuRjwc550YH82aE8uD0EA9w5a11kyGDnVoA-91AqhnQOg4aKjYQ0EXbwBoq3yXhLx0r6Chmak9nqWOHh4LQskmDQMJGj-bn1OwI2BpdPTREopBYvPhy4XGezmojGOwE5Pcme19HoTDLao5VNBPkBWHtEIEwgu3e1Xq5XMOrRCV87iaja69O9TzyLdPVUAmXrKS5UOmhVzKW2MrjyCNprWud2jIZ1dqIvryCA07ifdyI5Va_a-Zo7Dt7td53k9X9Y63wDPGEoPsWDVEBJ_0cDdHQtqdbY25lliE8NoVcjlGcsIdpW7nIcRUYAyjMYilO45E0EsRLgmnsXPsuI32wSj2sE7j1nJ1BVZpiWM-hYNERH6GAjm8blkxTo75BL7vmpMWn75zEwcDl2u_YsUHYaiqucCHwACHTUll8KxyO-N6EYbasFJ8i-4QdUj9tiihw=w1691-h951-no?authuser=0',
            title: 'Ordenes'
          },
        ],
      }
    },
  }
</script>